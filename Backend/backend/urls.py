from django.urls import path
from .views import login_page, login_user

urlpatterns = [
    path("login/", login_page, name="login_page"),  # Halaman login
    path("login-user/", login_user, name="login_user"),  # Proses login
]
