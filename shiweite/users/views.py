import re
from random import randint
from users.models import User
from django.http import *
from django.shortcuts import *
from django.views import View
from libs.captcha.captcha import captcha  # 导入图片验证码库
from django_redis import get_redis_connection  # 导入redis包
from libs.yuntongxun.sms import CCP
from utils.response_code import RETCODE
from django.contrib.auth import login
from django.contrib.auth import *
# Create your views here.

# 注册
class RegisterView(View):
    def get(self,request):
        return render(request,'register.html')
    def post(self,request):
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
        if not all([mobile,password,password2,sms_code]):
            return HttpResponseBadRequest(content='参数不全')

        # 2 - 2、手机号格式是否正确
        if not re.match(r'^1[3-9]\d{9}$',mobile):
            return HttpResponseBadRequest(content='手机号码格式不正确')

        # 2 - 3、密码是否符合格式
        if not re.match(r'^[0-9a-zA-Z]{8,20}$',password) or not re.match(r'^[0-9a-zA-Z]{8,20}$',password2):
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
        user = User.objects.create_user(username=mobile,mobile=mobile,password=password)
        login(request,user)
        resp = redirect(reverse('home:index'))
        resp.set_cookie('is_login',True)
        resp.set_cookie('login_name',user.username)

        return resp

# 图片验证码
class ImageView(View):
    def get(self,request):
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
        text,image = captcha.generate_captcha()
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
    def get(self,request):
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
        if not all([mobile,image_code,uuid]):
            return JsonResponse({'code':RETCODE.NECESSARYPARAMERR,'errmsg':'参数不全'})
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
        if image_code.lower() !=image_code_redis.decode().lower():
            return JsonResponse({'code': RETCODE.IMAGECODEERR, 'errmsg': '图片验证码错误'})
            # return HttpResponseBadRequest(content='图片验证码错误')
        # 3、生成短信验证码：生成六位数的验证码
        sms_code = '%06d' % randint(0,999999)
        print(f'你的验证码是：{sms_code}')
        ccp = CCP()
        ccp.send_template_sms('17691149837', [sms_code, 5], 1)
        # 4、保存短信验证码内容到redis中,保存时间1分钟
        redis_conn.setex('sms:%s' % mobile, 60, sms_code)
        return JsonResponse({'code': RETCODE.OK, 'errmsg': '验证码发送成功'})

class LoginView(View):
    def get(self,req):
        return render(req,'login.html')
    def post(self,req):
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
        if not all([mobile,password]):
            return render(req,'login.html',{'msg':'参数不齐全'})
        # 2 - 1、手机号码是否符合规则
        if not re.match('^1[3-9]\d{9}$',mobile):
            return render(req, 'login.html', {'msg': '手机号码格式不正确'})
        # 2 - 2、密码是否符合规则
        if not re.match('^[a-z0-9A-Z]{8,20}$',password):
            return render(req, 'login.html', {'msg': '密码格式不正确'})
        # 3、用户认证登录
        # 使用django系统自带的用户认证代码将会返回一个user对象如果账号密码正确那么就返回该对象否则返回None
        return_user=authenticate(mobile=mobile,password=password)
        # 4、状态保持
        login(req,return_user)

        resp = redirect(reverse('home:index'))
        # 5、根据用户选择的是否记住登录状态进行判断
        if remember!='on': # 用户未勾选
            req.session.set_expiry(0) #当浏览器关闭后清空session
            resp.set_cookie('is_login',True)
            resp.set_cookie('login_name',return_user.username)
        else: #用户勾选
            req.session.set_expiry(None)  # 设置session的过期时间为默认值。这个默认值是2周
            resp.set_cookie('is_login', True,max_age=14*24*3600)
            resp.set_cookie('login_name', return_user.username,max_age=14*24*3600)
        # 6、设置cookie信息，为首页显示服务

        return resp
