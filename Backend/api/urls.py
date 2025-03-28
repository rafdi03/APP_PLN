from django.urls import path
from .views import YoloDetectView  # Hanya impor YoloDetectView

urlpatterns = [
    path('detect/', YoloDetectView.as_view(), name='detect'),
]
