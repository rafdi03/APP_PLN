import firebase_admin
from firebase_admin import credentials, auth, firestore

# Load Firebase credentials
cred = credentials.Certificate("backend/firebase_config/pln-project-a6867-firebase-adminsdk-fbsvc-4268279cd3.json")  
firebase_admin.initialize_app(cred)

# Firestore database
db = firestore.client()
