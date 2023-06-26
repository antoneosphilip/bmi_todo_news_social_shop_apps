import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';

class crateusermodel{
  String? name;
  String? phone;
  String? uId;
  String? email;
  bool? isEmailVerified=false;
  String? image;
  String? bio;
  String? cover;
bool?x;
  String?tokenn;
  String?date;




  crateusermodel({

    this.email,
    this.phone,
    this.uId,
    this.name,
    this.isEmailVerified,
    this.image,
    this.bio,
this.cover,
    this.x,
    this.tokenn,
    this.date,

  });
  crateusermodel.fromjson(Map<String,dynamic> json){
email=json['email'];
phone=json['phone'];
uId=json['uId'];
name=json['name'];
isEmailVerified=json['isEmailVerified'];
image=json['image'];
bio=json['bio'];
cover=json['cover'];
x=json['like'];
tokenn=json['token'];
date=json['createdAt'];



  }
  Map<String,dynamic>  tomap(){

return {
'name':name,
  'phone':phone,
  'uId':uId,
  'email':email,
  'isEmailVerified':isEmailVerified,
  'image':image,
  'bio':bio,
  'cover':cover,
  'like':x,
'token':tokenn,
  'createdAt':date,

};

  }



}