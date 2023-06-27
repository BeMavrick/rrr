import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class mylogin extends StatefulWidget {
  mylogin({super.key});

  @override
  State<mylogin> createState() => _myloginState();
}

class _myloginState extends State<mylogin> {
  bool hide = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  BuildContext? ctx;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login.jpg'), fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
      padding: EdgeInsets.only(left: 35, top: 130),
          child: Text('Welcome MFs', style: TextStyle(
        color: Colors.white, fontSize: 44),
          ),
      ),
    SingleChildScrollView(
      child: Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5, right: 35, left: 35),
      child: Column(
      children: [
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
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('Sign In', style: TextStyle(
    color: Colors.blue,
    fontSize: 27, fontWeight: FontWeight.w700
    ),),
    CircleAvatar(
    radius: 30,
    backgroundColor: Colors.blue,
    child: IconButton(
    onPressed: (){
      Navigator.pushNamed(context, 'rrr');
    },
    icon: Icon(Icons.arrow_forward),
    ),
    )
    ],
    ),
    SizedBox(
    height: 40,),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextButton(onPressed: (){
        Navigator.pushNamed(context, 'signup');
      }, child: Text('Sign Up', style: TextStyle(
    decoration: TextDecoration.underline,

    ),)),
    TextButton(onPressed: (){
    }, child: Text('Forgot Password', style: TextStyle(
    decoration: TextDecoration.underline,

    ),))
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

  void performLogin(BuildContext context) async{
    try{
      var data = await auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      if(data != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 10),
            backgroundColor: Colors.green,
            content: Text('Login Success')));
      }
    }
    on FirebaseAuthException catch (errormessage) {
      if(errormessage.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 10),
            backgroundColor: Colors.blue,
            content: Text('user not found')));
      }
      print(errormessage);
    }
  }
  void showSnackbar(String msg, color) {
    ScaffoldMessenger.of(ctx!).showSnackBar(SnackBar(
        duration: Duration(seconds: 10),
        backgroundColor: Colors.green,
        content: Text(msg)));
  }
}




