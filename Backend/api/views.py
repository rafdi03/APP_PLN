import os
import cv2
import torch
from django.http import JsonResponse
from django.views import View
from django.core.files.storage import default_storage
from ultralytics import YOLO
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator

# Load model YOLO
model = YOLO("best.pt")  # Ganti dengan model yang sesuai

@method_decorator(csrf_exempt, name='dispatch')  # Nonaktifkan CSRF untuk seluruh class
class YoloDetectView(View):
    def get(self, request, *args, **kwargs):
        """
        Metode GET untuk mengecek apakah API berjalan.
        """
        return JsonResponse({'message': 'API is running'}, status=200)

    def post(self, request, *args, **kwargs):
        if 'image' not in request.FILES:
            return JsonResponse({'error': 'No image uploaded'}, status=400)

        image = request.FILES['image']
        image_path = default_storage.save(f'temp/{image.name}', image)
        image_full_path = os.path.join(default_storage.location, image_path)

        # Baca gambar
        img = cv2.imread(image_full_path)

        # Jalankan YOLO untuk deteksi
        results = model(img)
        num_detections = len(results[0].boxes)  # Hitung jumlah objek yang terdeteksi

        # Hapus gambar setelah diproses
        os.remove(image_full_path)

        return JsonResponse({'detections': num_detections})
