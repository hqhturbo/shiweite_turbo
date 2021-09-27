from random import randint

from django.http import HttpResponseBadRequest, JsonResponse
from django.shortcuts import render,HttpResponse
from django.views import View
from libs.captcha.captcha import captcha  # 导入图片验证码库
from django_redis import get_redis_connection  # 导入redis包
from libs.yuntongxun.CCPRestSDK import *
from libs.yuntongxun.sms import CCP
# Create your views here.

# 注册
from utils.response_code import RETCODE


class RegisterView(View):
    def get(self,request):
        return render(request,'register.html')

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

        sms_code = '%06d' % randint(0,999999)
        print(f'你的验证码是：{sms_code}')
        ccp = CCP()
        ccp.send_template_sms('17691149837', [sms_code, 5], 1)
        return JsonResponse({'code': RETCODE.OK, 'errmsg': '验证码发送成功'})

