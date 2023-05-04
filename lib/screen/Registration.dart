

import 'package:android_studio/screen/Login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../SpinkitLoading/SignUploading.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final  FirebaseAuth _auth=FirebaseAuth.instance;
  String _email='', _password='';
  bool loading=false;

  final _alertSignUp =  const SnackBar(
    content: Center(child: Text('Email Already Exist!',style: TextStyle(color: Colors.red),)),
  );
  final _alertSignUp2 =  const SnackBar(
    content: Center(child: Text('Server Not Responding!',style: TextStyle(color: Colors.red),)),
  );
  final _successMsg =  const SnackBar(
    backgroundColor:Colors.transparent,
    duration: Duration(milliseconds: 2000),
    content: Center(child: Text('Account Created Successfully',style: TextStyle(color: Colors.red),)),
  );





  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        setState(()=>loading = true);
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        print('User created: ${user.user?.email}');
        ScaffoldMessenger.of(context).showSnackBar(_successMsg);
        
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignInEmail()));

      }on FirebaseAuthException catch (e) {
        print('Error creating user: $e');
       if(e !=null){

        setState(() {
          loading = false;
          if(e.code == 'email-already-in-use') {
            ScaffoldMessenger.of(context).showSnackBar(_alertSignUp);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(_alertSignUp2);
          }

        });
       }


      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return  loading? const SignUpLoading():Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding:const EdgeInsets.fromLTRB(10, 80, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                      validator: (input) {
                      if (input!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onSaved: (input) => _email = input!.trim(),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email'),
                  ),


                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: TextFormField(
                      validator: (input) {
                        if (input!.length <6) {
                          return 'Your password must be at least 6 characters';
                        }
                        return null;
                      },
                      onSaved: (input) => _password = input!.trim(),
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Sign Up'),
                  ),
                  Container(
                    padding: const EdgeInsets.all(30),
                    child: Row(
                      children: [
                        const Text('if have an account already click on login',style: TextStyle(fontStyle:FontStyle.italic),),
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child:const Text('Login'))
                      ],

                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
