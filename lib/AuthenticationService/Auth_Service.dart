import 'package:android_studio/screen/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth =FirebaseAuth.instance;

void SignOut()async{
  await _auth.signOut();

  }



