import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register User
  Future<String?> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return "Berhasil daftar";
    } on FirebaseAuthException catch (e) {
      return e.message; // Mengembalikan pesan error Firebase
    } catch (e) {
      return "Terjadi kesalahan: $e";
    }
  }

  // Login User
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Berhasil login";
    } on FirebaseAuthException catch (e) {
      return e.message; // Mengembalikan pesan error Firebase
    } catch (e) {
      return "Terjadi kesalahan: $e";
    }
  }

  // Logout User
  Future<void> logout() async {
    await _auth.signOut();
  }
}
