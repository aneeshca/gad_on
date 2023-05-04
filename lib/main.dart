

import 'package:android_studio/screen/HomeScreen.dart';
import 'package:android_studio/screen/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

var auth=FirebaseAuth.instance;
var islog = false;
checkLogin()async{
  auth.authStateChanges().listen((User? user) {
    if(user !=null && mounted){
      setState(() {
        islog=true;
      });
    }
  });
}

@override
void initState(){
  checkLogin();
  super.initState();
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: islog? HomeScreen():const SignInEmail(),
    );
  }
}

