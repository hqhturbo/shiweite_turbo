import re,json,os
from random import randint
from users.models import User
from django.http import *
from django.shortcuts import *
from django.views import View
from libs.captcha.captcha import captcha  # 导入图片验证码库
from django_redis import get_redis_connection  # 导入redis包
from libs.yuntongxun.sms import CCP
from utils.response_code import RETCODE
from django.contrib.auth import *
from home.models import ArticleCategory,Article
from django.contrib.auth.mixins import LoginRequiredMixin
from shiweite.settings import BASE_DIR,MEDIA_URL
'''
    LoginRequiredMixin使用方法：
    1、待验证的视图需要继承该类即可，它会自动验证身份信息
    2、如果用户未登录，那么就是匿名用户，当访问该视图时，会自动进行跳转到默认登录地址：accounts/login/?next=/usercenter/
    3、我们需要在setting.py中配置默认登录地址即可 
    4、在登录视图的post方法中，判断next有值跳转
'''

# 1 导入系统logging
import logging
# 2 创建日志署
logger = logging.getLogger('django_log')

# Create your views here.

# 注册
class RegisterView(View):
    def get(self, request):
        return render(request, 'register.html')

    def post(self, request):
        """
            实现思路：
            1、接收用户数据
            2、验证数据
                2 - 1、参数是否齐全
                2 - 2、手机号格式是否正确
                2 - 3、密码是否符合格式
                2 - 4、密码和确认密码是否一致
                2 - 5、短信验证码是否和redis中的一致

            3、保存注册信息
            4、返回响应跳转到指定页面
        """
        mobile = request.POST.get('mobile')
        password = request.POST.get('password')
        password2 = request.POST.get('password2')
        sms_code = request.POST.get('sms_code')
        # 2、验证数据
        # 2 - 1、参数是否齐全
        if not all([mobile, password, password2, sms_code]):
            return HttpResponseBadRequest(content='参数不全')

        # 2 - 2、手机号格式是否正确
        if not re.match(r'^1[3-9]\d{9}$', mobile):
            return HttpResponseBadRequest(content='手机号码格式不正确')

        # 2 - 3、密码是否符合格式
        if not re.match(r'^[0-9a-zA-Z]{8,20}$', password) or not re.match(r'^[0-9a-zA-Z]{8,20}$', password2):
            return HttpResponseBadRequest('密码长度、格式不正确，长度8-20，必须是数字、字母')
        # 2 - 4、密码和确认密码是否一致
        if password != password2:
            return HttpResponseBadRequest('两次输入密码不一致')
        # 获取redis中的短信验证码
        redis_conn = get_redis_connection()
        redis_sms_code = redis_conn.get('sms:%s' % mobile)
        if redis_sms_code.decode() != sms_code:
            return HttpResponseBadRequest('短信验证码错误')
        # 3 保存注册信息
        user = User.objects.create_user(username=mobile, mobile=mobile, password=password)
        login(request, user)
        resp = redirect(reverse('home:index'))
        resp.set_cookie('is_login', True)
        resp.set_cookie('login_name', user.username)

        return resp

# 图片验证码
class ImageView(View):
    def get(self, request):
        '''
              步骤：
              1、接收前端传递过来的uuid
              2、判断uuid失分获取到
              3、通过调用captcha来生成图片验证码（返回：图片内容和图片二进制）
              4、将图片内容保存到redis中。uuid作为key，图片内容作为值，同时还需要设置一个过期时间
              5、返回图片给前端
              :param request:
              :return:
        '''
        uuid = request.GET.get('uuid')
        if uuid is None:
            return HttpResponse('uuid不存在')
        # 3、通过调用captcha来生成图片验证码（返回：图片内容和图片二进制）
        text, image = captcha.generate_captcha()
        # 4、将图片内容保存到redis中。uuid作为key，图片内容作为值，同时还需要设置一个过期时间
        redis_conn = get_redis_connection('default')
        # name:数据key，这里采用img前缀：uuid
        # time:300秒后过期
        # value：对应key的值
        redis_conn.setex(name='img:%s' % uuid, time=300, value=text)
        # 5、返回图片给前端
        return HttpResponse(image, content_type='image/jpeg')

# 短信验证码
class SmsCodeView(View):
    def get(self, request):
        '''
            实现思路：
            1、接收参数
            2、参数验证
                2.1 验证参数是否齐全
                2.2 图片验证码的验证
                    连接reids，获取reids中图片验证码
                    判断图片验证码是否存在
                        如果图片验证码未过期，我们获取到之后就可以删除图片验证码
                        比对图片验证码（忽略用户大小写）
            3、生成短信验证码
            4、保存短信验证码内容到redis中
            5、发送短信
            6、返回响应信息
            :param request:
            :return:
        '''
        mobile = request.GET.get('mobile')
        image_code = request.GET.get('image_code')
        uuid = request.GET.get('uuid')
        if not all([mobile, image_code, uuid]):
            return JsonResponse({'code': RETCODE.NECESSARYPARAMERR, 'errmsg': '参数不全'})
        # 图片验证码的验证
        redis_conn = get_redis_connection()
        # 从redis中获取已经存入的图片验证码信息
        image_code_redis = redis_conn.get('img:%s' % uuid)
        if image_code_redis is None:
            return JsonResponse({'code': RETCODE.IMAGECODEERR, 'errmsg': '图片验证码不存在'})
            # return HttpResponseBadRequest(content='图片验证码不存在')
        # 删除redis中已经验证的图片验证码
        redis_conn.delete('img:%s' % uuid)
        # redis中取出的数据需要解码
        if image_code.lower() != image_code_redis.decode().lower():
            return JsonResponse({'code': RETCODE.IMAGECODEERR, 'errmsg': '图片验证码错误'})
            # return HttpResponseBadRequest(content='图片验证码错误')
        # 3、生成短信验证码：生成六位数的验证码
        sms_code = '%06d' % randint(0, 999999)
        print(f'你的验证码是：{sms_code}')
        ccp = CCP()
        ccp.send_template_sms('17691149837', [sms_code, 5], 1)
        # 4、保存短信验证码内容到redis中,保存时间1分钟
        redis_conn.setex('sms:%s' % mobile, 60, sms_code)
        return JsonResponse({'code': RETCODE.OK, 'errmsg': '验证码发送成功'})

# 登录
class LoginView(View):
    def get(self, req):
        return render(req, 'login.html')

    def post(self, req):
        '''
           实现思路：
           1、接收提交参数
           2、验证参数
            2-1、手机号码是否符合规则
            2-2、密码是否符合规则
           3、用户认证登录
           4、状态保持
           5、根据用户选择的是否记住登录状态进行判断
           6、设置cookie信息，为首页显示服务
           7、跳转到首页
           :param request:
           :return:
        '''
        # 1、接收提交参数
        mobile = req.POST.get('mobile')
        password = req.POST.get('password')
        remember = req.POST.get('remember')
        # 2、验证参数
        if not all([mobile, password]):
            return render(req, 'login.html', {'msg': '参数不齐全'})
        # 2 - 1、手机号码是否符合规则
        if not re.match('^1[3-9]\d{9}$', mobile):
            return render(req, 'login.html', {'msg': '手机号码格式不正确'})
        # 2 - 2、密码是否符合规则
        if not re.match('^[a-z0-9A-Z]{8,20}$', password):
            return render(req, 'login.html', {'msg': '密码格式不正确'})
        # 3、用户认证登录
        # 使用django系统自带的用户认证代码将会返回一个user对象如果账号密码正确那么就返回该对象否则返回None
        return_user = authenticate(mobile=mobile, password=password)
        if return_user is None:
            return render(req, 'login.html', {'msg': '账号或密码错误'})
        # 4、状态保持
        login(req, return_user)

        resp = redirect(reverse('home:index'))
        # 5、根据用户选择的是否记住登录状态进行判断

        next_page = req.GET.get('next')
        if next_page:
            resp = redirect(next_page)
        else:
            resp = redirect(reverse('home:index'))
        # username = json.dumps(return_user.username)
        if remember != 'on':  # 用户未勾选
            req.session.set_expiry(0)  # 当浏览器关闭后清空session
            resp.set_cookie('is_login', True)
            # resp.set_cookie('login_name', username)
            resp.set_cookie('login_name', return_user.username)
        else:  # 用户勾选
            req.session.set_expiry(None)  # 设置session的过期时间为默认值。这个默认值是2周
            resp.set_cookie('is_login', True, max_age=14 * 24 * 3600)
            # resp.set_cookie('login_name', username, max_age=14 * 24 * 3600)
            resp.set_cookie('login_name', return_user.username, max_age=14 * 24 * 3600)
        # 6、设置cookie信息，为首页显示服务
        return resp

# 退出
class LogoutView(View):

    def get(self, request):
        '''
        实现思路：
        1、清楚session数据
        2、删除cookie数据
        3、跳转到首页
        :param request:
        :return:
        '''
        # 实现思路：
        # 1、清楚session数据
        logout(request)
        # 2、删除cookie数据
        resp = redirect(reverse('home:index'))
        resp.delete_cookie('is_login')
        resp.delete_cookie('login_name')
        # 3、跳转到首页
        return resp

# 忘记密码
class ForgetPasswordView(View):
    def get(self, req):
        return render(req, 'forget_password.html')

    def post(self, request):
        '''
        实现思路：
        1、接收数据
        2、验证数据
            2-1、判断参数是否齐全
            2-2、手机号是否符合规则
            2-3、判断密码是否符合规则
            2-4、判断确认密码是否一致
            2-5、判断短信验证码是否正确
        3、根据手机号码进行用户信息的查询
        4、如果手机号查询出用户信息则进行用户密码的修改
        5、如果手机号没有查询出用户信息，则进行新用户的创建
        6、进行页面跳转，跳转到登录页面
        7、返回响应
        :param request:
        :return:
        '''
        # 1、接收数据
        mobile = request.POST.get('mobile')
        password = request.POST.get('password')
        password2 = request.POST.get('password2')
        sms_code = request.POST.get('sms_code')
        # 2、验证数据
        #     2-1、判断参数是否齐全
        if not all([mobile, password, password2, sms_code]):
            return HttpResponseBadRequest('缺少必要的参数')
        #     2-2、手机号是否符合规则
        if not re.match(r'^1[3-9]\d{9}$', mobile):
            return HttpResponseBadRequest('手机格式不正确')
        #     2-3、判断密码是否符合规则
        if not re.match(r'^[0-9A-Za-z]{8,20}$', password):
            return HttpResponseBadRequest('密码格式不正确')
        #     2-4、判断确认密码是否一致
        if password != password2:
            return HttpResponseBadRequest('两次密码输入不一致')
        #     2-5、判断短信验证码是否正确
        redis_conn = get_redis_connection('default')
        redis_sms_code = redis_conn.get('sms:%s' % mobile)
        if redis_sms_code is None:
            return HttpResponseBadRequest('短信验证码过期')
        try:
            if redis_sms_code.decode() != sms_code:
                return HttpResponseBadRequest('验证码错误')
        except Exception as e:
            logger.error(e)
            return HttpResponseBadRequest('验证码错误')
        # 3、根据手机号码进行用户信息的查询
        return_user = User.objects.filter(mobile=mobile).first()
        # 4、如果手机号查询出用户信息则进行用户密码的修改
        # 5、如果手机号没有查询出用户信息，则进行新用户的创建
        if return_user is None:
            try:
                User.objects.create_user(username=mobile, mobile=mobile, password=password)
            except Exception as e:
                logger.error(e)
                return HttpResponseBadRequest('注册失败')
        else:
            try:
                # 调用系统user对象的set_password()进行修改密码，该方法会对密码进行加密
                return_user.set_password(password)
                return_user.save()
            except Exception as e:
                logger.error(e)
                return HttpResponseBadRequest('修改密码失败')
        # 6、进行页面跳转，跳转到登录页面
        resp = redirect(reverse('users:login'))
        # 7、返回响应
        return resp

# 个人中心
class UserCenterView(LoginRequiredMixin,View):
    def get(self,req):
        # if not req.user.is_authenticated:
        #     return redirect(reverse('users:login'))
        userinfo = req.user
        context = {
            'username':userinfo.username,
            'mobile':userinfo.mobile,
            'avatar': userinfo.avatar.url if userinfo.avatar else None,
            'user_desc':userinfo.user_desc
        }
        return render(req,'usercenter.html',context=context)
    def post(self,req):
        '''
            实现思路：
            1、接收用户参数
            2、将用户参数更新到数据库
            3、更新cookie中的username
            4、刷新当前页面（重定向操作）
            5、返回相应
            :param request:
            :return:
        '''
        # 获取已登陆用户信息
        userinfo = req.user
        # 1、接收用户参数
        # 获取用户提交的用户名，如果没有就将已登录的用户名赋值
        username = req.POST.get('username')

        # 获取用户提交的介绍，如果没有就将已登录的介绍赋值
        user_desc = req.POST.get('desc',userinfo.username)
        # 获取用户头像(如果没有图片保存地址，则会默认保存到项目的根目录下。否则需要在settting中进行配置地址)
        avatar = req.FILES.get('avatar')
        # 2、将用户参数更新到数据库
        # # ajax显示照片
        # print(avatar)
        # if avatar == None:
        #     avatar = req.FILES.get('image')
        #     with open('media/' + avatar.name, 'wb') as f:
        #         for line in avatar:
        #             f.write(line)
        #     try:
        #         data = {
        #             'state': 1,
        #             'url': '/media/' + avatar.name
        #         }
        #         # ava = User.objects.filter(username=userinfo.username).first()
        #         # avat = str(ava.avatar)
        #         # print(BASE_DIR + MEDIA_URL + avat)
        #         # if ava != None:
        #         #     os.remove(BASE_DIR + MEDIA_URL + avat)
        #         return JsonResponse(data)
        #     except:
        #         data = {'state': 0}
        #         return JsonResponse(data)
        #
        try:
            userinfo.username = username
            userinfo.user_desc = user_desc
            if avatar:
                userinfo.avatar = avatar
            userinfo.save()
        except Exception as e:
            logger.error(e)
            return render(req, '404.html', {
                'context': '修改用户信息失败'
            })
        # 3、更新cookie中的username
        # 4、刷新当前页面（重定向）
        # username=json.dumps(userinfo.username)
        resp = redirect(reverse('users:usercenter'))
        # resp.set_cookie('login_name',username)
        resp.set_cookie('login_name',userinfo.username)
        # 5、返回相应
        return resp

# 写博客视图
class WriteBlogView(LoginRequiredMixin,View):
    def get(self,req):
        # 获取博客分类信息
        categories = ArticleCategory.objects.all()
        context = {
            'categories':categories
        }
        return render(req,'writeblog.html',context=context)

    def post(self,req):
        '''
            实现思路：
            1、接收数据
            2、验证数据
            3、数据入库
            4、跳转到指定页面
            :param request:
            :return:
        '''
        # 1、接收数据
        avatar = req.FILES.get('avatar')
        title = req.POST.get('title')
        category_id = req.POST.get('category_id')
        tags= req.POST.get('tags')
        sumary= req.POST.get('sumary')
        content= req.POST.get('content')
        user= req.user
        # ajax显示照片
        if avatar == None:
            avatar = req.FILES.get('image')
            with open('media/' + avatar.name, 'wb') as f:
                for line in avatar:
                    f.write(line)
            try:
                data = {
                    'state': 1,
                    'url': '/media/' + avatar.name
                }
                return JsonResponse(data)
            except:
                data = {'state': 0}
                return JsonResponse(data)
        # 2、验证数据
        # 2-1、参数齐全验证
        if not all([avatar,title,content,category_id,sumary]):
            return render(req, '404.html', {
                'context': '参数不齐全'
            })
        # 2-2判断分类id
        try:
            category = ArticleCategory.objects.filter(pk=category_id).first()
        except ArticleCategory.DoesNotExist:
            return render(req, '404.html', {
                'context': '没有该分类信息'
            })
        # 3、数据入库
        try:
            Article.objects.create(
                author=user,
                avatar=avatar,
                title=title,
                category=category,
                tags=tags,
                sumary=sumary,
                content=content,
            )
            os.remove(BASE_DIR + MEDIA_URL + avatar.name)
        except Exception as e:
            logger.error(e)
            return render(req, '404.html', {
                'context': '发布失败，请稍后重试'
            })
            # 4、跳转到指定页面
        return redirect(reverse('home:index'))