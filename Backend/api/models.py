from django.db import models

class ImageUpload(models.Model):
    image = models.ImageField(upload_to='uploads/')
    prediction = models.CharField(max_length=255, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.prediction
