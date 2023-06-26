import 'dart:convert';

class newpostmodel{
  String? name;
  String? uId;
  String? image;
  String? date;
  String? text;

  String? postimage;
  String? like;



  newpostmodel({


    this.uId,
    this.name,
    this.image,
    this.text,
    this.date,
    this.postimage,
    this.like,



  });
  newpostmodel.fromjson(Map<String,dynamic> json){
postimage=json['postimage'];
date=json['date'];
uId=json['uId'];
name=json['name'];
image=json['image'];
text=json['text'];
like=json['like'];

  }
  Map<String,dynamic>  tomap(){

return {
'name':name,
  'postimage':postimage,
  'uId':uId,
  'date':date,
  'text':text,
  'image':image,
  'like':like,
};

  }



}