import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shopapp/modules/shop_app/model/homemodel.dart';
import 'package:shopapp/modules/shop_app/model/homemodel.dart';
import 'package:shopapp/modules/shop_app/model/homemodel.dart';
import 'package:shopapp/modules/shop_app/model/homemodel.dart';
import 'package:shopapp/modules/shop_app/model/homemodel.dart';

import 'homemodel.dart';

class homemodel{
   bool? status;
  homedata? data;
  homemodel.fromjson(Map<String,dynamic> json){
    status=json['status'];
    data=homedata.fromjson(json['data']);
  }
}
class homedata {
  List<bannersobject>? banners = [];
  List<productsobject>? products = [];

  homedata.fromjson(Map<String, dynamic> json){
    json['banners'].forEach((element) {
      banners?.add(bannersobject.fromjson(element));
    });

    json['products'].forEach((element) {
      products?.add(productsobject.fromjson(element));
    });
  }
}



class bannersobject{
int ?id;
String?image;
bannersobject.fromjson(Map<String,dynamic> json){
id=json['id'];
image=json['image'];
}

}
class productsobject{
int ?id;
dynamic?price;
dynamic?oldprice;
dynamic?discount;
String?image;
String?name;
bool?in_favorites;
bool?in_cart;
productsobject.fromjson(Map<String,dynamic> json){
  id=json['id'];
  price=json['price'];
  oldprice=json['old_price'];
  discount=json['discount'];
  image=json['image'];
  name=json['name'];
  in_favorites=json['in_favorites'];
in_cart=json['in_cart'];


}



}