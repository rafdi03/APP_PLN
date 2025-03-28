import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Uint8List? _imageBytes;
  String? _initials;
  String _detectionResult = "";
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchUserInitials();
  }

  Future<void> _fetchUserInitials() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        String fullName = userDoc['name'] ?? 'User';
        List<String> nameParts = fullName.split(" ");
        setState(() {
          _initials = nameParts.map((e) => e[0]).take(2).join().toUpperCase();
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final Uint8List bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
        isLoading = true; // Mulai loading
        _detectionResult = "";
      });

      // Upload gambar ke API setelah dipilih
      _uploadImageToAPI(bytes, pickedFile.name);
    }
  }

  Future<void> _uploadImageToAPI(Uint8List imageBytes, String fileName) async {
    var url = Uri.parse('http://192.168.1.7:8080/api/detect/');
    var request = http.MultipartRequest('POST', url);

    request.files.add(
      http.MultipartFile.fromBytes('image', imageBytes, filename: fileName),
    );

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonData = jsonDecode(responseData);
        setState(() {
          _detectionResult = "Hasil Deteksi: ${jsonData['detections']} objek ditemukan";
        });
      } else {
        setState(() {
          _detectionResult = "Gagal mendeteksi gambar";
        });
      }
    } catch (e) {
      setState(() {
        _detectionResult = "Terjadi kesalahan: $e";
      });
    } finally {
      setState(() {
        isLoading = false; // Selesai loading
      });
    }
  }

  void _deleteImage() {
    setState(() {
      _imageBytes = null;
      _detectionResult = "";
    });
  }

  void _showFullScreenImage() {
    if (_imageBytes != null) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          child: InteractiveViewer(
            panEnabled: false,
            boundaryMargin: EdgeInsets.all(20),
            minScale: 0.5,
            maxScale: 4.0,
            child: Image.memory(_imageBytes!, fit: BoxFit.contain),
          ),
        ),
      );
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TracePoint PLN",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          if (_initials != null)
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  _initials!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
        ],
      ),
      drawer: _buildDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.circular(20),
              ),
              child: _imageBytes != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.memory(_imageBytes!, fit: BoxFit.cover),
                    )
                  : const Center(
                      child: Icon(Icons.add, color: Colors.white, size: 50),
                    ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text("Input Image"),
            ),
            if (isLoading) ...[
              const SizedBox(height: 10),
              const CircularProgressIndicator(), // Loading Indicator
            ],
            if (_imageBytes != null && !isLoading) ...[
              const SizedBox(height: 10),
              Text(
                _detectionResult,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _showFullScreenImage,
                    child: const Text("Lihat Gambar"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _deleteImage,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text(
                      "Hapus Gambar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.blue[900]),
            accountName: _initials != null
                ? Text(
                    _initials!,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                : const Text("User"),
            accountEmail: FirebaseAuth.instance.currentUser != null
                ? Text(FirebaseAuth.instance.currentUser!.email ?? "")
                : const Text(""),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: _initials != null
                  ? Text(
                      _initials!,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.blue),
                    )
                  : const Icon(Icons.person, size: 40),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: _logout,
          ),
        ],
      ),
    );
  }
}
