from django.contrib import admin
from users.views import RegisterView
from django.urls import path, include

urlpatterns = [
    path('register/', RegisterView.as_view(), name='register'),
]

