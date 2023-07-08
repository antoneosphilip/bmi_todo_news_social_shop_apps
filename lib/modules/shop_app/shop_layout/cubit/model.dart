class modelquantity{
  int? quantity;
  int ?price;

  modelquantity.fromjson(Map<String,dynamic> json){
    quantity=json['quantity'];
    price=json['price'];


  }



}