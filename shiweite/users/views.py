from django.shortcuts import render,HttpResponse
from django.views import View
from libs.captcha.captcha import captcha  # 导入图片验证码库
from django_redis import get_redis_connection  # 导入redis包
# Create your views here.

# 注册
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