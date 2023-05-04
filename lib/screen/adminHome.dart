import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:android_studio/screen/Login.dart';

import '../AuthenticationService/Auth_Service.dart';




class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final user=FirebaseAuth.instance.currentUser;
 final FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Admin')
        ,
        actions: [
          ElevatedButton(onPressed: ()async{
            SignOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignInEmail()));
          }, child: const Text('SignOut'))

        ],

      ),
      body:


      Column(
        children: [

          Center(child: Text( 'hai admin : ${user!.email}')),// <-- SEE HERE

          TextFormField(

          )

        ],
      )

    );
  }
}
