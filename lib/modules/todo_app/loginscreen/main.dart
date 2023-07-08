import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Network/remote/diohelper.dart';
import 'package:shopapp/cubit/cubit.dart';
import 'package:shopapp/layout/todo%20app/home_layout.dart';





Future<void> main() async {

  runApp(const MyApp());

}
class MyApp extends StatelessWidget
{
  const MyApp({key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,

      home: BlocProvider(create:(context)=> Appcubit(),child: homelayout(),)
        //



    );
  }
}
