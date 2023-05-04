

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:android_studio/screen/HomeScreen.dart';
import '../screen/adminHome.dart';
import 'Registration.dart';
import 'package:android_studio/SpinkitLoading/SignInLoading.dart';


class SignInEmail extends StatefulWidget {
  const SignInEmail({Key? key}) : super(key: key);


  @override
  State<SignInEmail> createState() => _SignInEmailState();
}

class _SignInEmailState extends State<SignInEmail> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _email='', _password='',error='';
  bool loading=false;


//SnackBar error messages
  final _alertSignIn =  const SnackBar(

    content: Center(child: Text('User Not Found',style: TextStyle(color: Colors.red),)),
  );
  final _alertSignIn2 =  const SnackBar(

    content: Text('The Password Is Incorrect',style: TextStyle(color: Colors.red),),
  );
  final _alertSignIn3 =  const SnackBar(

    content: Text('server not responding',style: TextStyle(color: Colors.red),),
  );





  void _submitForm() async {

    if (_formKey.currentState!.validate()) {

      _formKey.currentState!.save();
      try {
        setState(() =>loading=true);

        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
        print('User signed in: ${user.user?.email}');
        final ActEmail=user.user?.email;

        if(ActEmail == 'kannanca02@gmail.com'){
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => const AdminHome()));

        }else{
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
        }


      }on FirebaseAuthException catch (e) {
        if(e !=null){
          setState(() {
             loading=false;

            if(e.code == 'user-not-found') {
              ScaffoldMessenger.of(context).showSnackBar(_alertSignIn);
            } else if(e.code == 'wrong-password') {
              ScaffoldMessenger.of(context).showSnackBar(_alertSignIn2);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(_alertSignIn3);
            }





          });

        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return   loading ? const LoadingScreen(): Scaffold(


      appBar: AppBar(title: const Text('Sign In')),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 80, 10, 0),
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
                    padding:const EdgeInsets.fromLTRB(0, 20, 0,0),
                    child: TextFormField(
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Please enter your password';
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
                    onPressed: _submitForm

                    ,
                    child: const Text('Sign In'),

                  ),



                  Padding(

                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Row(

                      children: [
                        const Text('if you don''t'' have an account please login!',style: TextStyle(fontStyle: FontStyle.italic),),

                        TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUp()));

                          },
                          child: const Text('Register'),
                        ),
                      ],

                    ),
                  ),

               //   Text( _EmailErr,style: const TextStyle(color: Colors.red)),
                ],
              ),
            ),


          ),
        ),

      ),
    );
  }



}



