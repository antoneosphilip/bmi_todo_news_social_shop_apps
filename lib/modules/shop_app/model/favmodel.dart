class favmodel{
  bool?status;
  String? message;
  favmodel.fromjson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
  }

}