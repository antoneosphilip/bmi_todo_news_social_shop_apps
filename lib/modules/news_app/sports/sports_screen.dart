
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componet/mmm.dart';
import 'package:shopapp/layout/newsapp/cubit.dart';
import 'package:shopapp/layout/newsapp/states.dart';



class sportsscreen extends StatelessWidget {
  const  sportsscreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {

    return BlocConsumer<newcubit,newsstates>
      (
      listener: (context,state){},
      builder: (context,state){

        return ConditionalBuilder(

          condition:  newcubit.get(context).sports.length>0,
          builder:(context)=> ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder:(context,index)=> builddio(
              newcubit.get(context).sports[index],context
            ),
            separatorBuilder:(context,index)=>seprator() ,
            itemCount:  newcubit.get(context).sports.length,
          ),
          fallback:(context)=>Center(child: CircularProgressIndicator()),
        );
      },

    );

  }}
