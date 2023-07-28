
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/shop_app/model/category-model.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/cubit-shoplayout.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/states.dart';

class categoriesscreen extends StatelessWidget {
  const categoriesscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shoplayoutcubit,shoplayoutstates>
      (
        builder: (context,state){
          return ConditionalBuilder(
            condition: shoplayoutcubit.get(context).modelcategory!=null,
            builder: (context)=>ListView.separated(
                itemBuilder: (context,index)=>categoriesitems(shoplayoutcubit.get(context).modelcategory!.data!.data![index]),
                separatorBuilder: (context,index)=>SizedBox(height: 10,),
                itemCount: shoplayoutcubit.get(context).modelcategory!.data!.data!.length
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator(
              color: Colors.deepOrange,
            )),
          );

    },
        listener: (context,state){}
    );
  }
}
Widget categoriesitems(datamodel model)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Image(
        image: NetworkImage('${model.image}'),
        height: 80,
        width: 80,
        fit: BoxFit.cover,
      ),
      SizedBox(width: 20,),
      Text(
        "${model.name}",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),

      ),
      Spacer(),
      Icon(
        Icons.arrow_forward_ios,
      ),

    ],
  ),
);
