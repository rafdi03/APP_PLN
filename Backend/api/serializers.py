from rest_framework import serializers
from .models import YourModel  # Ganti dengan model Anda

class YourModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = YourModel
        fields = '__all__'  # Atau tentukan fields yang ingin dikirim