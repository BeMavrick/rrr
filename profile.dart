import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';


class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final dbRef = FirebaseDatabase.instance.ref('User');
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Mirdul')),
        body: StreamBuilder(
            stream: dbRef
                .child(auth.currentUser!.uid.toString())
                .onValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              else if (!snapshot.hasData) {
                return Text('no record');
              }
              else {
                Map<dynamic, dynamic> data =
                snapshot.data!.snapshot.value as dynamic;
                return Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          openImagePicker();
                          print('image');
                        },
                        child: ClipOval(
                            child: Image.network(
                              data['image'],
                              fit: BoxFit.fill,
                              height: 100,
                              width: 100,
                            )
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      ListTile(
                        tileColor: Colors.brown,
                        leading: Icon(Icons.person, color: Colors.yellow),
                        title: Text('name'),
                        textColor: Colors.blue,
                        subtitle: Text(data['name'].tostring()),
                      ),

                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        tileColor: Colors.brown,
                        leading: Icon(Icons.person, color: Colors.yellow),
                        title: Text('email'),
                        textColor: Colors.blue,
                        subtitle: Text(data['email'].tostring()),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        tileColor: Colors.brown,
                        leading: Icon(Icons.person, color: Colors.yellow),
                        title: Text('password'),
                        textColor: Colors.blue,
                        subtitle: Text(data['password'].tostring()),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        tileColor: Colors.brown,
                        leading: Icon(Icons.person, color: Colors.yellow),
                        title: Text('address'),
                        textColor: Colors.blue,
                        subtitle: Text(data['address'].tostring()),
                      ),
                    ],
                  ),
                );
              }
            }
        )
    );
  }
}
  void openImagePicker() async {
    ImagePicker picker = ImagePicker();
    XFile? imgFile = await picker.pickImage(source: ImageSource.gallery);
    if (imgFile != null) {
      sendImageToFirebase(imgFile);

    }
  }

  void sendImageToFirebase(XFile imgFile) async{
    final stref = await FirebaseStorage.instance.ref('user');
    var fileName = DateTime.now().microsecondsSinceEpoch.toString();
    stref.child('image/$fileName').putFile(File(imgFile.path));
  }


