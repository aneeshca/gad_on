import 'package:cloud_firestore/cloud_firestore.dart';

Future createUser(product) async {
  final docProduct=FirebaseFirestore.instance.collection('gadon').doc();
  product.pId=docProduct.id;
  final json=product.toJson();
  await docProduct.set(json);

}
