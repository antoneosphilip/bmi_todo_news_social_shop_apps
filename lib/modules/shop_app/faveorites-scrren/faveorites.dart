
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/shop_app/model/fav-model2.dart';
import 'package:shopapp/modules/shop_app/model/homemodel.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/cubit-shoplayout.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/states.dart';
import 'package:shopapp/shared/styles/styles.dart';

import '../../../componet/mmm.dart';
import '../productscrren/productscreen.dart';

class faveoritesscreen extends StatelessWidget {
  const faveoritesscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<shoplayoutcubit,shoplayoutstates>
      (
        builder: (context,state){
          return ConditionalBuilder(
            condition: shoplayoutcubit.get(context).modelfaveorite!=null,
            builder:(context)=> ListView.separated(
              itemBuilder: (context,index)=>buildlistitem(shoplayoutcubit.get(context).modelfaveorite!.data!.data![index]!.product,context,index,isdisc: true),
              separatorBuilder: (context,index)=>SizedBox(height: 20,),
              itemCount:shoplayoutcubit.get(context).modelfaveorite!.data!.data!.length,
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator(color: Colors.deepOrange,)),
          );

        },

        listener: (context,state){}
    );
  }

}