

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Network/remote/diohelper.dart';
import 'package:shopapp/model/model.dart';
import 'package:shopapp/modules/cubit-Register/states.dart';
import 'package:shopapp/shared/styles/styles.dart';

class shopregistercubit extends Cubit<shopregisterstates>{

  static shopregistercubit get(context)=>BlocProvider.of<shopregistercubit>(context);

  shopregistercubit():super(shopregisterintialstates());
  bool icon=false;
  shoploginmodel? registermodel;

  userlogin({
  required name,
    required phone,
  required email,
    required password,

}){
    emit(shopregisterloadingstates());
Diohelper.putdata(
  url: REGISTER,
    data: {
    'email':email,
      'password':password,
      'name':name,
      'phone':phone,
    })!.then((value) {
      registermodel=shoploginmodel.fromjson(value?.data);
      emit(shopregistersucessstates(registermodel!));
    }).catchError((error){
  emit(shopregistererrorstates());
});
  }
  void changeicon(){
    icon=!icon;

    emit(shopregistericontates());
  }


}