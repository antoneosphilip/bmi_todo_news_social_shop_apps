import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shopapp/Network/login/login.dart';
import 'package:shopapp/Network/remote/diohelper.dart';
import 'package:shopapp/model/model.dart';
import 'package:shopapp/modules/social-app/social-logins-creen/cubit/states.dart';



class socialappcubit extends Cubit<socialappstates>{

  static socialappcubit get(context)=>BlocProvider.of<socialappcubit>(context);

  socialappcubit():super(socialappintialstates());
  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

  bool icon=false;
  shoploginmodel? model;
  // crateusermodel? model;

  // void getuserdata() {
  //
  //   emit(socialintialtates());
  //   FirebaseFirestore.instance.collection('user').doc(model?.uId).get().then((value) {
  //
  //     model = crateusermodel.fromjson(value.data()!);
  //
  //     emit(socialcreateusersuccesstates());
  //   }).catchError((error) {
  //     emit(socialcreateusererrortates());
  //   });
  // }
  void settoken() {
    final FirebaseMessaging _messaging = FirebaseMessaging.instance;
    late String currentToken;
    String userId = FirebaseAuth.instance.currentUser!.uid;
    _messaging.getToken().then((value) {
      print(value);
      currentToken = value!;
      emit(socialsendtokenlogintates());
      FirebaseFirestore.instance
          .collection('user')
          .doc(uId)
          .update({'token': value!, 'createdAt': DateTime.now()});
    });

  }

  userlogin({
    required email,
    required password
}){
    emit(socialapploadingstates());
FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password,
).then((value) {

  print(value.user?.displayName);
  emit(socialappsucessstates(value.user!.uid!.toString()));


}).catchError((error){
  print(error.toString());
  emit(socialapperrorstates(error.toString()));

  });
  }
  void changeicon(){
    icon=!icon;

emit(socialappicontates());
  }

}