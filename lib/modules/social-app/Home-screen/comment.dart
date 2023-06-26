import 'dart:convert';

import 'package:flutter/cupertino.dart';

class likemodel{

  Map<String,dynamic> ?like;



  likemodel.fromjson(Map<String,dynamic> json){
    // json['comment'].forEach((element){
    //   like?.add(element);
    // });
    like=json['comment'];
  }
  Map<String,dynamic>  tomap(){

return {

  'comment':like,
};

  }



}