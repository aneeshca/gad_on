class Product{
  final String name;
  final String price;
  final String model;
  final String description;
  final String protype;
  String pId;
  Product({this.pId ='',required this.name,required this.price,required this.model,required this.description,required this.protype});

 Map<String ,dynamic> toJson()=>{
   'id':pId,
   'name':name,
   'price':price,
   'model':model,
   'description':description,
   'product_type':protype
 };
}

