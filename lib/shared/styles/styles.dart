import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/shop_app/model/category-model.dart';
import 'package:shopapp/modules/shop_app/model/fav-model2.dart';
import 'package:shopapp/modules/shop_app/search-scrren/cubit/cubit.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/cubit-shoplayout.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/states.dart';

import '../../modules/shop_app/faveorites-scrren/faveorite-details/fevarote-details.dart';
import '../../modules/shop_app/search-scrren/search-model/search-model.dart';

const HOME='home';
const Category='categories';
const Fav='favorites';
const PROFILE='profile';
const REGISTER='register';
const updatePROFILE='update-profile';
const SEARCH='products/search?';
const cart='carts';
const order='/v2/checkout/orders';

// const cart='carts';



Widget buildlistitem( model, BuildContext context,index,{required bool isdisc}) =>
    BlocConsumer<shoplayoutcubit,shoplayoutstates>
      (builder: (context,state){
      return
        InkWell(
          onTap: (){

            Navigator.push(context, MaterialPageRoute(builder:(context)=> faveroitedetails(shoplayoutcubit.get(context).modelfaveorite!,index)));
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 120,
              child: Row(
                children: [
                  Stack(
                    children: [
                      Image(
                        image: NetworkImage(
                            '${model!.image}'
                        ),
                        width: 120,
                        height: 120,
                      ),
                      if(model?.discount != 0&&isdisc==true)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,),
                          color: Colors.red,
                          child: Text('Discount',
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                    alignment: AlignmentDirectional.bottomStart,

                  ),
                  SizedBox(width: 20,),
                  Container(
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${model!.name}',
                            style: TextStyle(fontSize: 14,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,

                          ),
                          Spacer(),
                          Row(
                            children: [
                              Text(
                                '${model?.price}'+"\£",
                                style: TextStyle(fontSize: 12,
                                  color: Colors.deepOrange,
                                ),
                              ),
                              SizedBox(width: 5,),
                              if(model?.discount != 0 && isdisc==true)
                                Text(
                                  '${model?.oldPrice}'+"\£",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              Spacer(),
                              IconButton(

                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  if(model.id!=0)
                                    shoplayoutcubit.get(context).changefav(model?.id);
                                  if(model.id!=null);


                                },

                                icon: CircleAvatar(

                                    radius: 15,
                                    backgroundColor: shoplayoutcubit.get(context).faveorite![model?.id]!?Colors.deepOrange :Colors.grey,

                                    child: Icon(
                                      Icons.favorite_border_outlined,
                                      size: 14,
                                      color: Colors.white,
                                    )
                                ),


                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        );

    }
        , listener: (Context,state){}
    );



