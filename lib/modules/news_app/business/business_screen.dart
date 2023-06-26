
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componet/mmm.dart';

import 'package:shopapp/layout/newsapp/cubit.dart';
import 'package:shopapp/layout/newsapp/states.dart';

class businessscreen extends StatelessWidget {
  const  businessscreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {

    return BlocConsumer<newcubit,newsstates>
      (
      listener: (context,state){},
        builder: (context,state){

        return ConditionalBuilder(
            condition:  newcubit.get(context).business.length>0,
            builder:(context)=> ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder:(context,index)=> builddio(
               newcubit.get(context).business[index],context
              ),
                separatorBuilder:(context,index)=>seprator() ,
                itemCount:  newcubit.get(context).business.length,
            ),
          fallback:(context)=>Center(child: CircularProgressIndicator()),
        );
        },

    );

  }}