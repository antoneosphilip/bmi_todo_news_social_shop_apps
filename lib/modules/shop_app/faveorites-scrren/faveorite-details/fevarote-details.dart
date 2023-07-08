import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopapp/componet/mmm.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/cubit-shoplayout.dart';
import 'package:shopapp/modules/social-app/social-logins-creen/cubit/cubit.dart';

import '../../../../Network/login/login.dart';
import '../../../../Network/login/login.dart';
import '../../../cart-screen/cart-screen.dart';
import '../../model/fav-model2.dart';
import '../../shop_layout/cubit/states.dart';

class faveroitedetails extends StatelessWidget {
  faveoritesmodel model;
  int idex ;

  faveroitedetails(this.model, this.idex);

  @override
  Widget build(BuildContext context) {
    shoplayoutcubit.get(context).price=model?.data?.data![idex].product!.price;
    bool x=true;
    shoplayoutcubit.get(context).pm=1;


    return BlocConsumer<shoplayoutcubit,shoplayoutstates>(
      listener: (context,state){
        if(state is shopcartsucessstateshop){

          toast(text: shoplayoutcubit.get(context).cmodel!.message!, choose: toastchoose.success);

        }
        if(state is shopcartsucessstateshop){
          shoplayoutcubit.get(context).y=shoplayoutcubit.get(context).price!+shoplayoutcubit.get(context).y;
          print('total');
          print(shoplayoutcubit.get(context).y);


        }

      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(),

          body:  Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(state is cartsendemodelloading)
                  LinearProgressIndicator(
                    color: Colors.deepOrange,
                  ),
                FittedBox(

                  child: Container(


                    height: 400,

                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    width: 400,

                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(10),

                      image: DecorationImage(


                        image: NetworkImage('${model.data?.data![idex].product?.image}',

                        ),




                      ),
                    ),

                  ),
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${model.data?.data![idex].product?.name}'
                      ),
                      SizedBox(height: 10,),
                      Text('total price:${shoplayoutcubit.get(context).price} \£',
                        style: TextStyle(

                        ),

                      ),

                    ],
                  ),
                ),

                Expanded(
                  child: Row(
                    children: [

                      Expanded(

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.deepOrange,

                              radius: 20,
                              child: IconButton(onPressed: (){
                                shoplayoutcubit.get(context).remove(index: idex);
                              }, icon: Icon(
                                Iconsax.minus,
                                size: 19,
                              )),

                            ),
                            Text("Minus"),
                          ],
                        ),
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              IconButton(onPressed: (){
                                print(shoplayoutcubit.get(context).cmodel?.data?.quantity);
                              }, icon: Icon(Iconsax.shopping_cart,size: 30,)),
                              Text("${ shoplayoutcubit.get(context).pm
                              }",style: TextStyle(fontSize: 15)),
                            ],
                          )


                        ],
                      ),
                      Spacer(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.deepOrange,
                              radius: 20,
                              child: IconButton(

                                  onPressed: (){
                                    shoplayoutcubit.get(context).add(index: idex);
                                  }, icon: Icon(
                                Iconsax.add,
                                size: 19,
                              )),

                            ),
                            Text("Add"),
                          ],
                        ),
                      ),
                    ],
                  ),

                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepOrange,

                  ),
                  width: double.infinity,
                  child: Column(
                    children: [
                      MaterialButton(

                        onPressed: (){

                          shoplayoutcubit.get(context).addcart(id:model.data?.data![idex].product!.id,idex: idex);
                          shoplayoutcubit.get(context).setmodel(index: model.data?.data![idex].product!.id,quantity: shoplayoutcubit.get(context).pm
                              ,idex: idex
                          );
                          if(shoplayoutcubit.get(context).cartgetmodel2?.data?.total==0.0)
                          {
                            shoplayoutcubit.get(context).pro=[];
                            shoplayoutcubit.get(context).pricee=[];

                            //   shoplayoutcubit.get(context).price=0;

                          }
                          // if(shoplayoutcubit.get(context).t==0){
                          //
                          //   shoplayoutcubit.addcart(id: cartgetmodel2?.data?.cartItems![index].product?.id, idex: index);
                          //
                          // }

                          shoplayoutcubit.get(context).getqu(index: model.data?.data![idex].product!.id);
                          //    cartscreen(idex);
                       //   shoplayoutcubit.get(context).paypal(context: context,index: idex);

                       //   cartscreen(1)!;

                          shoplayoutcubit.get(context).pm=0;
                        },
                        child: Text(
                            "Add to cart" ,
                            style: TextStyle(
                              color: Colors.white,


                            )),

                        minWidth: double.infinity,
                      ),



                    ],
                  ),
                )
              ],
            ),
          ),

        );
      },
    );

  }
}
