class shopprofilemodel{
  bool ?statues;
  String ?message;
  userlogin? data;
  shopprofilemodel.fromjson(Map<String,dynamic> json){
    statues=json['status'];
    message=json['message'];
    data=(json['data'] !=null? userlogin.fromjson(json['data']):null);


  }

}
class userlogin{
  int? id;
  String? name;
  String? email;
  String ?phone;
  String? image;
  int? point;
  int? credit;
  String ?token;
  userlogin.fromjson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    point=json['point'];
    credit=json['credit'];
    token=json['token'];



  }
}