
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubit/cubit.dart';
import 'package:shopapp/layout/newsapp/cubit.dart';
import 'package:shopapp/layout/newsapp/states.dart';
import 'package:shopapp/modules/news_app/search/search-screen.dart';

class newsapplayout extends StatelessWidget {
  const newsapplayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newcubit,newsstates>(
    listener: (context,state){},
    builder: (context,state){
    return Scaffold(
      appBar: AppBar(

title: Text(
  "News app",
),
    actions: [
        IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder:(context)=>search(),
          ));
        }, icon: Icon(Icons.search),
        ),
      IconButton(
          onPressed:(){
        Appcubit.get(context).changecolormode();

      },
          icon:Icon(Icons.brightness_4_outlined)),
    ],

      ),
      body:
      newcubit.get(context).screens[newcubit.get(context).currentindex],
bottomNavigationBar: BottomNavigationBar(
    items:newcubit.get(context).bottomitem,
  currentIndex: newcubit.get(context).currentindex,
  onTap: (index){
      newcubit.get(context).changebottom(index);
  },

),





    );

    });
}}
