


import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Network/login/login.dart';
import 'package:shopapp/layout/social-layout/social-cubit/social-cubit.dart';
import 'package:shopapp/model/social-model/social-model.dart';
import 'package:shopapp/modules/social-app/chats-screen/chats-details/chats-details.dart';

import '../../../layout/social-layout/social-cubit/social-states.dart';
import 'feeds2screen/feeds2-screen.dart';

class feedsscreen extends StatelessWidget {
  const feedsscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  BlocConsumer<sociallayoutcubit,shoplayoutstates>(
        listener: (context,state){},
        builder: (context,state){

          return ConditionalBuilder(
            condition:sociallayoutcubit.get(context).users!.length>0 ,
      
            builder:(context)=>ListView.separated(
                itemBuilder: (context,index)=>chats(sociallayoutcubit.get(context).users![index],context,index),
                separatorBuilder: (context,index)=>Container(
                  child: SizedBox(height: 5,),
                  height: 4,
                ),

                itemCount: sociallayoutcubit.get(context).users?.length??0),
            fallback:(context)=>Center(child: CircularProgressIndicator()) ,
          );
        },
      ),

    );
  }


  Widget chats(crateusermodel model,context,index)=> InkWell(
    onTap: (){
      var token=FirebaseMessaging.instance.getToken();
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>feeds2screen(model,index)));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(

            backgroundImage:NetworkImage(

                '${model.image}'
            ),

            radius: 25,
          ),
          SizedBox(width: 15,),
          Text(
            '${model.name}'
            ,
            style: TextStyle(height: 1.4),

          ),

        ],
      ),
    ),
  );
}
