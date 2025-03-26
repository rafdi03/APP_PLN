import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> imageList = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final ListResult result = await FirebaseStorage.instance.ref('users/${user.uid}').listAll();
    List<Map<String, dynamic>> tempList = [];

    for (var item in result.items) {
      final url = await item.getDownloadURL();
      tempList.add({'url': url, 'ref': item});
    }

    setState(() {
      imageList = tempList;
    });
  }

  Future<void> _deleteImage(Reference ref) async {
    await ref.delete();
    _loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("History")),
      body: ListView.builder(
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(imageList[index]['url']),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteImage(imageList[index]['ref']),
            ),
          );
        },
      ),
    );
  }
}
