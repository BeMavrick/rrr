import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class mysignup extends StatefulWidget {
  const mysignup({super.key});

  @override
  State<mysignup> createState() => _mysignupState();
}

class _mysignupState extends State<mysignup> {
  bool hide = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _nameController = TextEditingController();
  BuildContext? ctx;
  FirebaseAuth regAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/signup.jpg'), fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black12,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 30),
              child: Text('Create Account', style: TextStyle(
                  color: Colors.white, fontSize: 44),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.28, right: 35, left: 35),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextField(
                      controller: _addressController,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Address',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Sign Up', style: TextStyle(
                            color: Colors.purple,
                            fontSize: 27, fontWeight: FontWeight.w700
                        ),),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'profile');
                            },
                            icon: Icon(Icons.arrow_forward),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showSnackbar(String msg, color) {
    ScaffoldMessenger.of(ctx!).showSnackBar(SnackBar(
        duration: Duration(seconds: 10),
        backgroundColor: color,
        content: Text(msg)));
  }

  void performSignup(BuildContext context) async {
    try {
      var respo = await regAuth.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      if (respo != null) {
        sendDataToFirebase(respo);
        showSnackbar(
            'Register success',
            Colors.green
        );
        Navigator.pushNamed(ctx!, 'login');
      }
    }
    on FirebaseAuthException catch (error) {
      showSnackbar(
        error.toString(),
        Colors.red,
      );
    }
  }
  void sendDataToFirebase(UserCredential respo) {
    DatabaseReference dbRef = FirebaseDatabase.instance.ref('User');
    dbRef.child(respo.user!.uid.toString()).set({
      'name':_nameController.text,
      'address':_addressController.text,
      'password':_passwordController.text,
      'email':_emailController.text,
    });
  }
}
