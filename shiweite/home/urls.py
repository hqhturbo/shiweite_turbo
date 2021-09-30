"""
# -*- coding: utf-8 -*-
-------------------------------------------------
# @Project  :shiweite
# @File     :urls.py
# @Date     :2021/9/27 17:45
# @Author   :turbo
# @Email    :2647387166
# @Software :PyCharm
-------------------------------------------------
"""
from django.contrib import admin
from home.views import *
from django.urls import path, include

urlpatterns = [
    path('', IndexView.as_view(), name='index'),
    path('detail/',DetailView.as_view(),name='detail')
]

