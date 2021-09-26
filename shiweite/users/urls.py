from django.contrib import admin
from users.views import RegisterView,ImageView
from django.urls import path, include

urlpatterns = [
    path('register/', RegisterView.as_view(), name='register'),
    path('imagecode/',ImageView.as_view(),name='imagecode')
]

