import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class SignUpLoading extends StatelessWidget {
  const SignUpLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body:
      Container(
        color: Colors.white70,

        child:  const Center(
          child: SpinKitRotatingCircle(
            duration: Duration(milliseconds: 5000),
            color: Colors.deepPurpleAccent,
          ),
        ),
      )

      ,



    );
  }
}
