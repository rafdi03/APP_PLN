import os
import cv2
from ultralytics import YOLO  # Pastikan ultralytics sudah diinstal

# Path ke model YOLO (ganti sesuai lokasi model)
MODEL_PATH = "best.pt"

# Load model YOLO
model = YOLO(MODEL_PATH)

# Path ke gambar uji (ganti dengan gambar yang ingin diuji)
IMAGE_PATH = "tes.jpg"

# Baca gambar
img = cv2.imread(IMAGE_PATH)

# Pastikan gambar tidak kosong
if img is None:
    print(f"Error: Tidak dapat membaca gambar di {IMAGE_PATH}")
    exit()

# Jalankan YOLO untuk deteksi
results = model(img)

# Ambil informasi deteksi
for result in results:
    boxes = result.boxes.xyxy  # Bounding box (x1, y1, x2, y2)
    scores = result.boxes.conf  # Confidence score
    class_ids = result.boxes.cls  # Class ID

    print("\nDeteksi ditemukan:")
    for i in range(len(boxes)):
        print(f"Objek {i + 1}:")
        print(f" - Koordinat  : {boxes[i].tolist()}")
        print(f" - Confidence : {scores[i].item():.2f}")
        print(f" - Class ID   : {int(class_ids[i].item())}")

# Menampilkan gambar dengan bounding box (opsional)
for box in boxes:
    x1, y1, x2, y2 = map(int, box)
    cv2.rectangle(img, (x1, y1), (x2, y2), (0, 255, 0), 2)

cv2.imshow("Deteksi YOLO", img)
cv2.waitKey(0)
cv2.destroyAllWindows()
