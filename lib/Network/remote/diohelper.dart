
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Diohelper{
 static Dio? dio;
 static init(){
   dio =Dio(
       BaseOptions(
         baseUrl: 'https://student.valuxapps.com/api/',
         receiveDataWhenStatusError: true,

       )
   );

 }
 static Future<Response?>? getdata({
   required String url,
    Map<String,dynamic>? query,
   String lang='en',
   String? token,

 })async{
dio?.options.headers={
  'Content-Type':'application/json',
  'lang':lang,
  'Authorization':token??'',

};

  return await dio?.get(
   url,queryParameters: query
   );
 }
 static Future<Response?>? putdata({
   required String url,
   Map<String,dynamic>? query,
   required Map<String,dynamic> data,
   String lang='en',
   String? token,

 })async
 {
   dio?.options.headers={
     'Content-Type':'application/json',
 'lang':lang,
   'Authorization':'key=AAAAK0-A6Ok:APA91bEY56LfSgzJyyJeENdbkZus0OQxD6t1J5U0CVZAuvI7wXV8rVR7QWWBJh5klt3B-FNtJd0ubaod-HcphIs7cv9dGfbtLs83-f0TXW8XuCatVAUSPfRAhCBC_BRdZrb6QGSQSVbS',

   };
   return  dio?.post(url,queryParameters: query,data: data);
 }
 static Future<Response?>? postdata({
   required String url,
   Map<String,dynamic>? query,
   required Map<String,dynamic> data,
   String lang='en',
   String? token,

 })async
 {
   dio?.options.headers={
     'Content-Type':'application/json',
     'lang':lang,
     'Authorization':token??'',

   };
   return  dio?.put(url,queryParameters: query,data: data);
 }

}
class shared
{
  static SharedPreferences? sharedPreferences;
  static init() async{
sharedPreferences=await SharedPreferences.getInstance();
  }
static Future<bool?> putbooldata({
  required String key,
  required bool value,
})async{
   return await sharedPreferences?.setBool(key, value);
}
  static Future<bool?> savedata({
    required dynamic key,
    required dynamic value,
  })async{
    if(value is String) return await sharedPreferences?.setString(key, value);
    if(value is bool) return await sharedPreferences?.setBool(key, value);
    if(value is double) return await sharedPreferences?.setDouble(key, value);
    if(value is int) return await sharedPreferences?.setInt(key, value);
  }

 static dynamic getdata({
    required String key,
  }) {
    return sharedPreferences?.get(key);
  }
static Future<bool?> clear (
    {required key,}
    )async
{
   return await sharedPreferences?.remove(key);
}
}