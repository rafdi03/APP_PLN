import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final ImagePicker _picker = ImagePicker();
  String? _initials;

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
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final Uint8List bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  void _deleteImage() {
    setState(() {
      _imageBytes = null;
    });
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _showFullScreenImage() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 3.0,
                child: Image.memory(_imageBytes!, fit: BoxFit.contain),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Tutup", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TracePoint PLN", style: TextStyle(color: Colors.white)),
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
            if (_imageBytes != null) ...[
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _showFullScreenImage,
                child: const Text("Lihat Gambar"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _deleteImage,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Hapus Gambar", style: TextStyle(color: Colors.white)),
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
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.blue,
                      ),
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