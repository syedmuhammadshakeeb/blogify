import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fi_app/views/home_view/home_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final titlecontroller = TextEditingController();
  final descriptiocontroller = TextEditingController();
  FirebaseFirestore ref = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  ImagePicker picker = ImagePicker();
  File? imageFile;
  String? imageUrl;

  addimage() async {
    final pick = await picker.pickImage(source: ImageSource.gallery);
    if (pick != null) {
      imageFile = File(pick.path);
      setState(() {});
    }
  }

  uploadImage() async {
    await firebaseStorage.ref().child('images/$imageFile').putFile(imageFile!);
    imageUrl =
        await firebaseStorage.ref().child('images/$imageFile').getDownloadURL();
  }

  addData() async {
    await ref.collection('data').add({
      'title': titlecontroller.text,
      'Description': descriptiocontroller.text,
      'image': imageUrl
    }).then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }).onError((error, stackTrace) => null);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            addData();
          },
          child: const Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              imageFile != null
                  ? Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height / 4.5,
                          width: MediaQuery.of(context).size.width,
                          child: Image.file(
                            imageFile!,
                          )),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Material(
                        child: GestureDetector(
                          onTap: () {
                            addimage();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 4.5,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(20)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                                Text(
                                  'Upload',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              ElevatedButton(
                  onPressed: () {
                    uploadImage();
                  },
                  child: const Text('uplaod to storage')),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: titlecontroller,
                  maxLines: 4,
                  maxLength: 50,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blueAccent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: descriptiocontroller,
                  maxLines: 50,
                  maxLength: 500,
                  decoration: InputDecoration(
                    hintText: 'whats in your mind?',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blueAccent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
