import os
from django.conf import settings
from django.http import JsonResponse
from django.views import View
from django.core.files.storage import default_storage
import cv2
from ultralytics import YOLO  # Pastikan ultralytics sudah diinstal

# Path lengkap ke model
MODEL_PATH = os.path.join(settings.BASE_DIR, "best.pt")

# Load model YOLO
model = YOLO(MODEL_PATH)

class YoloDetectView(View):
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
