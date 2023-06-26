

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shopapp/Network/remote/diohelper.dart';
import 'package:shopapp/layout/social-layout/social-cubit/social-cubit.dart';
import 'package:shopapp/model/model.dart';
import 'package:shopapp/modules/social-app/Registershopscreen/cubit-Register/states.dart';

import '../../../../Network/login/login.dart';
import '../../../../layout/social-layout/social-cubit/social-states.dart';
import '../../../../model/social-model/social-model.dart';


class socialappregistercubit extends Cubit<socialappregisterstates>{

  static socialappregistercubit get(context)=>BlocProvider.of<socialappregistercubit>(context);





  socialappregistercubit():super(socialappregisterintialstates());


  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
  crateusermodel? model;
  bool icon=false;
  shoploginmodel? registermodel;
  void settoken() {
    final FirebaseMessaging _messaging = FirebaseMessaging.instance;
    late String currentToken;
    String userId = FirebaseAuth.instance.currentUser!.uid;
    _messaging.getToken().then((value) {
      print(value);
      currentToken = value!;
      emit(socialtokensates());
      FirebaseFirestore.instance
          .collection('user')
          .doc(uId)
          .update({'token': value!, });
    });

  }

  userlogin({
    required name,
    required phone,
    required  email,
    required password,


}){
    emit(socialappregisterloadingstates());
print(model?.image);
FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
  createuser(name: name, phone: phone, email: email, uId: value.user?.uid);
  settoken();
}).catchError((error){

  print(error);
  emit(socialappregistererrorstates(error!.toString()));
});

  }
  void getuserdata() {
    emit(socialappgetusersuccesstates());
    FirebaseFirestore.instance.collection('user').doc(model?.uId).snapshots().listen((event) {
      model = crateusermodel.fromjson(event.data()!);

      emit(socialappgetusererrortates());
    });
  }

  createuser({
     required name,
    required  phone,
    required  email,
    required  uId,

  }){
    crateusermodel model=crateusermodel(

      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image: 'https://img.freepik.com/free-photo/front-view-smart-man-holding-his-glasses_23-2148946278.jpg?w=1060&t=st=1686993913~exp=1686994513~hmac=32c0821a4f537b281b3b3497ba1eef6baac2f33c6788cb230ae0ef67ee57d705',
bio: "Enter your bio",
      cover:'https://img.freepik.com/free-photo/front-view-man-enjoying-music-his-headphones_23-2148946268.jpg?t=st=1686995164~exp=1686995764~hmac=184c5218b9347a02d56cb52c0cec1d69d3df32ffd9798b4e34af7b15372cacd0',
date: formattedDate,
    );
    print(name);
    FirebaseFirestore.instance.collection("user").doc(uId).set(model.tomap()).then((value) {
emit(socialappcreateusersucessstates(uId.toString()));

    }).catchError((error){
      emit(socialappcreateusererrorstates(error.toString()));


    });

  }
  void changeicon(){
    icon=!icon;

    emit(socialappregistericontates());
  }


}