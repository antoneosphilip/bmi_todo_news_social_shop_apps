
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp/Network/login/login.dart';
import 'package:shopapp/Network/remote/diohelper.dart';
import 'package:shopapp/componet/mmm.dart';
import 'package:shopapp/cubit/cubit.dart';
import 'package:shopapp/cubit/states.dart';
import 'package:shopapp/layout/newsapp/cubit.dart';
import 'package:shopapp/layout/newsapp/newsapp_layout.dart';
import 'package:shopapp/layout/social-layout/social-layout.dart';
import 'package:shopapp/layout/todo%20app/home_layout.dart';
import 'package:shopapp/modules/paypal-screen/paypal-screen.dart';
import 'package:shopapp/modules/shop_app/loginshopscreen/loginshop_screen.dart';
import 'package:shopapp/modules/shop_app/on_boardingapp/on_boardingapp.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/cubit-shoplayout.dart';
import 'package:shopapp/modules/shop_app/shop_layout/shop_layout.dart';
import 'package:shopapp/modules/social-app/feedsscreen/feeds-screen.dart';
import 'package:shopapp/modules/social-app/social-logins-creen/social-login.dart';
import 'package:shopapp/shared/styles/thems.dart';

import 'Network/login/login.dart';
import 'layout/social-layout/social-cubit/social-cubit.dart';
import 'modules/cart-screen/cart-screen.dart';
import 'modules/social-app/Home-screen/Home-screen.dart';
import 'modules/social-app/Registershopscreen/cubit-Register/cubit.dart';
import 'modules/social-app/social-logins-creen/cubit/cubit.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
  toast(text: 'on messgae background', choose: toastchoose.success);

}

void main()async {


  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');


  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
    toast(text: 'on messgae', choose: toastchoose.success);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    toast(text: 'on messgae opened', choose: toastchoose.success);

  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  token2=(await FirebaseMessaging.instance.getToken())!;
  // final user = await FirebaseAuth.instance.currentUser!;
  // final idToken = await user.getIdToken();
  // print(idToken);

  print("tokkkkkkkkkkkken");
  print(token2);

  await runZonedGuarded(() async {
    Widget widget;
    WidgetsFlutterBinding.ensureInitialized();
    Diohelper.init();
    await shared.init();

    dynamic board= shared.getdata(key: "isboard");
    dynamic isDark=await shared.getdata(key:'light');
    dynamic islogin=shared.getdata(key: "token");
    //uId='';
    if(uId!=''){
      uId=shared.getdata(key: 'uId');

    }
    // if(uId!=null){
    //   widget =sociallayoutscreen();
    // }else{
    //
    //   widget=socialapploginscreen();
    // }
if(token!=null){
  token=shared.getdata(key: 'token') ;

}
    print(token);
    if(board!=null){
      if(islogin!=null) widget=shoplayout();

      else{
        widget=loginshopscreen();
      }
    }else{
      widget=onboardingscreen();
    }

    runApp(MyApp(board: board,isDark: isDark,widget: widget));
  }, (error, stack) {print(error);
  }
  );


}

class MyApp extends StatelessWidget
{
  final bool ?isDark;
  final bool ?board;
  final Widget? widget;
  MyApp({
    this.board,
    this.isDark,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {


    return  MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=>newcubit()..getdata()),
        BlocProvider(create: (context)=>Appcubit()..changecolormode(dark: isDark)),
        BlocProvider(create: (context)=>shoplayoutcubit()..homedata()..categorydata()..faveoritedata()..profiledata()),
        BlocProvider(create: (context)=>sociallayoutcubit()..getuserdata()..getusers()..getuserposts()




        ),
        //  BlocProvider(create: (context)=>socialappcubit()..getuserdata()),



      ],
      child: BlocConsumer<Appcubit,Appstates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:lighttheme ,
            darkTheme:darktheme ,
            themeMode: Appcubit.get(context).light? ThemeMode.dark : ThemeMode.light,
            home: widget !,


          );
        },
      ),
    );
  }
}