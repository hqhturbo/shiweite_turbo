from django.contrib import admin
from users.views import *
from django.urls import path, include

urlpatterns = [
    # 参数1：路由
    # 参数2：视图函数
    # 参数3：路由名，方便通过reverse来获取路由
    path('register/', RegisterView.as_view(), name='register'),
    # 图片验证码路由
    path('imagecode/',ImageView.as_view(),name='imagecode'),
    path('smscode/', SmsCodeView.as_view(),name='smcode'),
    path('login/', LoginView.as_view(),name='login'),
    path('logout/', LogoutView.as_view(),name='logout'),
    path('forgetpassword/', ForgetPasswordView.as_view(), name='forgetpassword'),
]

