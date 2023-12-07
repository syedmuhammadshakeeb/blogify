import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fi_app/views/blog_view/blog_view.dart';
import 'package:fi_app/views/read_blog_view/read_blog_view.dart';
import 'package:fi_app/views/login_view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore ref = FirebaseFirestore.instance;

  logout() {
    auth.signOut().then((value) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BlogScreen()));
            },
            child: const Icon(Icons.menu),
          ),
          drawer: const Drawer(),
          body: StreamBuilder(
              stream: ref.collection('data').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Builder(builder: (context) {
                          return IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: const Icon(Icons.menu),
                          );
                        }),
                        trailing: IconButton(
                            onPressed: () {
                              logout();
                            },
                            icon: const Icon(Icons.logout_outlined)),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'BLOG',
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.blueAccent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.blueAccent),
                              )),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ListTile(
                                  leading: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.grey)),
                                    child: Image.network(
                                      snapshot.data!.docs[index]['image'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      snapshot.data!.docs[index]['title'],
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              '${DateTime.now().hour.toString()}/${DateTime.now().minute.toString()}/${DateTime.now().second}'),
                                        ]),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        ref
                                            .collection('data')
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete();
                                        setState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.grey,
                                      )),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ReadBlogScreen(
                                                  img: snapshot.data!
                                                      .docs[index]['image']
                                                      .toString(),
                                                  head: snapshot.data!
                                                      .docs[index]['title'],
                                                  title:
                                                      snapshot.data!.docs[index]
                                                          ['Description'],
                                                )));
                                  },
                                ),
                              );
                            }),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Lottie.asset('assets/lo.json',
                        reverse: true, repeat: true),
                  );
                }
              })),
    );
  }
}
