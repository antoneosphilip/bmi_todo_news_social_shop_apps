

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componet/mmm.dart';
import 'package:shopapp/modules/shop_app/cubit/cubit.dart';
import 'package:shopapp/modules/shop_app/model/fav-model2.dart';
import 'package:shopapp/modules/shop_app/model/homemodel.dart';
import 'package:shopapp/modules/shop_app/search-scrren/cubit/cubit.dart';
import 'package:shopapp/modules/shop_app/search-scrren/cubit/states.dart';
import 'package:shopapp/modules/shop_app/search-scrren/search-model/search-model.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/cubit-shoplayout.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/states.dart';
import 'package:shopapp/shared/styles/styles.dart';

class searchscreen extends StatelessWidget {
  var seachcontroller=TextEditingController();
int i=1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>searchcubit(),
      child: BlocConsumer<searchcubit,shopsearchstates>
        (
          listener: (context,state){},
          builder: (context,state){
    return Scaffold(
    appBar: AppBar(),
    body: Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: defaulttext(
              controller: seachcontroller,
              type: TextInputType.text,
              prefix: Icons.search,
              onsubmited: (String text){
                searchcubit.get(context).search(text);
              },
              text: 'Search',
              validate: ((value){
                if(value==null){
                  return "enter text";
                }
                else{
                  return null;
                }
              }),
            ),

          ),
          if(state is shopsearchloadingstate)
            LinearProgressIndicator(),
          SizedBox(height: 20,),
          if(state is shopsearchsuccessstate)
          Expanded(
            child: ListView.separated(itemBuilder: (context,index)=>buildlistitem(searchcubit.get(context).Smodel!.data!.data![index]!,context,index,isdisc: false),
              separatorBuilder: (context,index)=>SizedBox(height: 10,),
              itemCount:searchcubit.get(context).Smodel!.data!.data!.length,
            ),
          ),

        ],
      ),
    ),


    );

    },


    ),
    ) ;
  }

}

