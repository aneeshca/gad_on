import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class ProductSpinkit extends StatelessWidget {
  const ProductSpinkit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body:
      Container(
        color: Colors.white70,

        child: const Center(
          child: SpinKitCircle(
            duration: Duration(milliseconds: 10000),
            color: Colors.deepPurpleAccent,
          ),
        ),
      )

      ,



    );
  }
}
