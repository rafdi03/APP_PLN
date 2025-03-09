from django.shortcuts import render, redirect
from django.http import JsonResponse
from firebase_admin import auth
from django.views.decorators.csrf import csrf_exempt
import json

# Tampilkan halaman login
def login_page(request):
    return render(request, "login.html")

# Login ke Firebase via Form
@csrf_exempt
def login_user(request):
    if request.method == "POST":
        email = request.POST.get("email")
        password = request.POST.get("password")

        if not email or not password:
            return render(request, "login.html", {"error": "Email dan password harus diisi!"})

        try:
            # Login ke Firebase (Gunakan API Firebase REST Authentication)
            import requests
            firebase_api_key = "AIzaSyDGtHUBEiEvB7txoHRMUy8TARehsMafh2s"  # Ganti dengan API Key Firebase kamu
            firebase_auth_url = f"https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key={firebase_api_key}"

            data = {
                "email": email,
                "password": password,
                "returnSecureToken": True
            }

            response = requests.post(firebase_auth_url, json=data)
            result = response.json()

            if "idToken" in result:
                return JsonResponse({"message": "Login berhasil", "uid": result["localId"]})
            else:
                return render(request, "login.html", {"error": "Login gagal. Cek email atau password!"})

        except Exception as e:
            return render(request, "login.html", {"error": str(e)})

    return render(request, "login.html")
