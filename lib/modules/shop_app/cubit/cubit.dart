import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Network/login/login.dart';
import 'package:shopapp/Network/remote/diohelper.dart';
import 'package:shopapp/model/model.dart';
import 'package:shopapp/modules/shop_app/cubit/states.dart';
import 'package:shopapp/modules/shop_app/loginshopscreen/loginshop_screen.dart';

class shopcubit extends Cubit<shopstates>{

  static shopcubit get(context)=>BlocProvider.of<shopcubit>(context);

  shopcubit():super(shopintialstates());
  bool icon=false;
  shoploginmodel? model;

  userlogin({
    required email,
    required password
}){
    emit(shoploadingstates());
Diohelper.putdata(
  lang: 'ar',
  url: LOGIN,
    data: {
    'email':email,
      'password':password,

    })!.then((value) {
      print(value.toString());

      model=shoploginmodel.fromjson(value?.data);
      emit(shopsucessstates(model!));

    }).catchError((error){
  print(error);
  emit(shoperrorstates());
});
  }
  void changeicon(){
    icon=!icon;

emit(shopicontates());
  }

}