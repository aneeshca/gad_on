import 'package:android_studio/model/product.dart';
import 'package:android_studio/screen/Login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:android_studio/AuthenticationService/Auth_Service.dart';
import '../AuthenticationService/databaseServices.dart';
import '../SpinkitLoading/productadd.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  var user=FirebaseAuth.instance.currentUser;
  final _controllerName=TextEditingController();
  final _controllerPrice=TextEditingController();
  final _controllerModel=TextEditingController();
  final _controllerDescription=TextEditingController();
  final _controllerProductType=TextEditingController();

  bool _showErrorName = false;
  bool _showErrorPrice = false;
  bool _showErrorModel = false;
  bool _showErrorDescription = false;
  bool _showErrorProductType = false;

  bool _isloading=false;
 
  final _successMsg =  SnackBar(
    backgroundColor:Colors.transparent,
    duration: const Duration(milliseconds: 2000),
    content: Container(
             padding: const EdgeInsets.all(15),
        height: 90,
         decoration: const BoxDecoration(
          color: Colors.greenAccent,
           borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Column(
          children: const [
            Text('Success!',style:TextStyle(fontSize: 18,color: Colors.white),),
            Text('Product Added Successfully',style: TextStyle(color: Colors.deepPurpleAccent,fontSize: 14,),),
          ],
        )),
    behavior: SnackBarBehavior.floating,
  );
  final _errorMessage =  SnackBar(
    backgroundColor:Colors.transparent,
    duration: const Duration(milliseconds: 2000),
    content: Container(
        padding: const EdgeInsets.all(15),
        height: 90,
        decoration: const BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Column(
          children: const [
            Text('Failed!',style:TextStyle(fontSize: 18,color: Colors.white),),
            Text("Product Can\t Added Successfully",style: TextStyle(color: Colors.deepPurpleAccent,fontSize: 14,),),
          ],
        )),
    behavior: SnackBarBehavior.floating,
  );


  @override
  Widget build(BuildContext context) {


    return  _isloading? const ProductSpinkit():Scaffold(
      appBar: AppBar(
        title:const Text('Home Screen'),
        backgroundColor: Colors.blue,
        actions: [
          ElevatedButton(onPressed:()async{
            SignOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignInEmail()));

          }, child: const

          Icon( Icons.logout_outlined,color: Colors.red,),

          ),


        ],

      ),
      body:

      ListView(

        children:   [
           Container(
               padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
               child:const Text('Add Products Details',style: TextStyle(fontStyle: FontStyle.normal,fontSize: 25,color: Colors.greenAccent,fontWeight: FontWeight.bold),)),
          Padding(
           padding: const EdgeInsets.all(15),
           child: TextField(

              controller: _controllerName,
             decoration: InputDecoration(labelText: 'enter product name',
             border: const OutlineInputBorder(),
               errorText: _showErrorName ? 'Product Name Can\'t Be Empty' : null,

             ),
           onChanged: (text) {
         setState(() {
        _showErrorName = text.isEmpty;
         });
         }

           ),
         ),
           Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _controllerPrice,
              decoration:  InputDecoration(labelText: 'enter product price',
                border: OutlineInputBorder(),
                errorText: _showErrorPrice ? 'Price Can\'t Be Empty' : null,
              ),
                onChanged: (text) {
                  setState(() {
                    _showErrorPrice = text.isEmpty;
                  });
                }
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _controllerModel,
              decoration:  InputDecoration(labelText: 'enter product model',
                border: OutlineInputBorder(),
                errorText: _showErrorModel ? 'Value Can\'t Be Empty' : null,
              ),
                onChanged: (text) {
                  setState(() {
                    _showErrorModel = text.isEmpty;
                  });
                }
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _controllerDescription,
              decoration:  InputDecoration(labelText: 'enter product description',
                border: OutlineInputBorder(),
                errorText: _showErrorDescription ? 'Description Can\'t Be Empty' : null,
              ),
                onChanged: (text) {
                  setState(() {
                    _showErrorDescription = text.isEmpty;
                  });
                }
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _controllerProductType,
              decoration:  InputDecoration(labelText: 'enter product type',
                border: OutlineInputBorder(),
                errorText: _showErrorProductType ? 'Product Type Can\'t Be Empty' : null,
              ),
                onChanged: (text) {
                  setState(() {
                    _showErrorProductType = text.isEmpty;
                  });
                }
            ),
          ),


        Padding(
          padding: const EdgeInsets.all(15),
          child: ElevatedButton(onPressed: (){

             final product=Product(
                 name :_controllerName.text,
                 price:_controllerPrice.text,
                 model: _controllerModel.text,
                 description:_controllerDescription.text,
                 protype: _controllerProductType.text


             );

           setState(() {
             setState(()=>_isloading = true);
             _controllerName.text.isEmpty ? _showErrorName = true : _showErrorName = false;
             _controllerPrice.text.isEmpty ? _showErrorPrice = true : _showErrorPrice = false;
             _controllerModel.text.isEmpty ? _showErrorModel = true : _showErrorModel = false;
             _controllerDescription.text.isEmpty ? _showErrorDescription = true : _showErrorDescription = false;
             _controllerProductType.text.isEmpty ? _showErrorProductType = true : _showErrorProductType = false;

             if(_controllerName.text.isNotEmpty && _controllerPrice.text.isNotEmpty && _controllerModel.text.isNotEmpty && _controllerDescription.text.isNotEmpty && _controllerProductType.text.isNotEmpty){
               createUser(product).then((value)  {
                 ScaffoldMessenger.of(context).showSnackBar(_successMsg);
                 Navigator.push(context,
                     MaterialPageRoute(builder: (context) => const HomeScreen()));
               }).catchError((onError){
                 ScaffoldMessenger.of(context).showSnackBar(_errorMessage);
                 Navigator.push(context,
                     MaterialPageRoute(builder: (context) => const HomeScreen()));
                 _isloading=false;
               });
             }




           });


          }, child:const Text('submit')),
        ),
        ],


      ),

    );
  }


}
