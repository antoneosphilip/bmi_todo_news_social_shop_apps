import 'dart:convert';

class commentmodel{

   bool ?like2;



  commentmodel.fromjson(Map<String,dynamic> json){
   like2=json['like'];
  }
  Map<String,dynamic>  tomap(){

return {

  'like':like2,
};

  }



}