
import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopapp/Network/login/login.dart';
import 'package:shopapp/Network/login/login.dart';
import 'package:shopapp/Network/login/login.dart';
import 'package:shopapp/Network/login/login.dart';
import 'package:shopapp/Network/login/login.dart';
import 'package:shopapp/modules/shop_app/model/cart-model.dart';
import 'package:shopapp/modules/shop_app/model/cartgetmodel.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/cubit-shoplayout.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/states.dart';
import 'package:shopapp/modules/social-app/social-logins-creen/cubit/cubit.dart';

import '../../../../componet/mmm.dart';


class cartscreen extends StatelessWidget {
  final int index;

  cartscreen(this.index);
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {

        shoplayoutcubit.get(context).getcartmodel();
shoplayoutcubit.get(context).k=false;
        return BlocConsumer<shoplayoutcubit,shoplayoutstates>(
          listener: (context,state){
            if(state is shopcartsucessstateshop){
              toast(text: shoplayoutcubit.get(context).cmodel!.message!, choose: toastchoose.success);

            }
            if(state is orderindatabasesuccess){
              toast(text: "Be waiting for the order and thank you for contacting us", choose: toastchoose.success);

            }
          },
          builder: (context,state){
            return  Scaffold(
              appBar: AppBar(title: Text('my cart'),),
              body: ConditionalBuilder(

                condition: shoplayoutcubit.get(context).cartgetmodel2!=null&&state is! shopcartdeletesucessstateshop&& state is!deletequantitysucccess,
                builder: (context)=>Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    if(state is cartsendemodelloading)
                      SizedBox(height: 5,),
                    if(state is cartsendemodelloading)

                      LinearProgressIndicator(
                        color:  Colors.deepOrange,
                      ),

                    if(shoplayoutcubit.get(context).cartgetmodel2?.data?.total>0)

                      Expanded(

                        child: ListView.separated(itemBuilder:(context,index)=> builditemart(shoplayoutcubit.get(context).cartgetmodel2!,index,shoplayoutcubit.get(context).qu?.quantity,context,state),
                          separatorBuilder:(context,index)=> SizedBox(height: 1,),
                          itemCount: shoplayoutcubit.get(context).cartgetmodel2!.data!.cartItems!.length!,

                        ),
                      ),
                    if(shoplayoutcubit.get(context).cartgetmodel2?.data?.total==0)
                      Center(child: Icon(Iconsax.shopping_cart,size: 50,color: Colors.grey,)),
                    if(shoplayoutcubit.get(context).cartgetmodel2?.data?.total==0)
                      SizedBox(height: 10,),
                    if(shoplayoutcubit.get(context).cartgetmodel2?.data?.total==0)
                      Center(
                        child: Text(" your cart is empity",
                          style: TextStyle(color: Colors.grey,fontSize: 20),
                        ),

                      ),

                    if(shoplayoutcubit.get(context).cartgetmodel2?.data?.total>0)
                      Text("total price: ${shoplayoutcubit.get(context).t.toInt()}"),
                    if(shoplayoutcubit.get(context).cartgetmodel2?.data?.total>0)

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,

                        ),

                        child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(10),

                            ),
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () async{
                                //
                                //AfiHpAhqhN_Sb9OCERuABNiA619kEy...
                                //AfiHpAhqhN_Sb9OCERuABNiA619kEy...
                                print(shoplayoutcubit.get(context).cartgetmodel2?.data?.total*shoplayoutcubit.get(context).q);
                                print(shoplayoutcubit.get(context).t);

                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PaypalCheckout(
                                        sandboxMode: true,
                                        clientId: "Af4hWmLO9XV1vXtwFYdMrz1c8x61a4gsf_dMA749514D2tET6nPMe2zvVHc0_Uvsgia6g9W-dbIKNmPs",
                                        secretKey: "EKUxU8LPALQV9GquBqoKBecAs8sYTObY8X8mmt-c3McR6-yaOj3u6jmYL4v669fqqGwuiRbmDKRQZAQh",
                                        returnURL: "success.snippetcoder.com",
                                        cancelURL: "cancel.snippetcoder.com",

                                        transactions: [
                                          {

                                            "amount": {
                                              //      if(shoplayoutcubit.get(context).t==shoplayoutcubit.get(context).pro*shoplayoutcubit.get(context).cartgetmodel2?.data?.cartItems![0].product?.price)

                                              "total": '${(shoplayoutcubit.get(context).t)}',
                                              "currency": "USD",
                                              "details": {
                                                //    if(shoplayoutcubit.get(context).t==shoplayoutcubit.get(context).pro[0]*shoplayoutcubit.get(context).cartgetmodel2?.data?.cartItems![0].product?.price)

                                                "subtotal":'${shoplayoutcubit.get(context).t}',
                                                "shipping": '0',
                                                "shipping_discount": 0
                                              }
                                            },
                                            "description": "The payment transaction description.",
                                            // "payment_options": {
                                            //   "allowed_payment_method":
                                            //       "INSTANT_FUNDING_SOURCE"
                                            // },

                                            "item_list": {

                                              "items": [


                                                for(int i=0;i<shoplayoutcubit.get(context).cartgetmodel2!.data!.cartItems!.length;i++){

                                                  "name": "${shoplayoutcubit.get(context).cartgetmodel2?.data?.cartItems![i].product?.name}",
                                                  "quantity": shoplayoutcubit.get(context).pro[i]
                                                  ,
                                                  "price": '${ (shoplayoutcubit.get(context).pricee[i]/shoplayoutcubit.get(context).pro[i])}',
                                                  "currency": "USD"


                                                }

                                              ],


                                              //     shipping address is not required though
                                              //        "shipping_address": {
                                              //          "recipient_name": "Raman Singh",
                                              //          "line1": "Delhi",
                                              //          "line2": "",
                                              //          "city": "Delhi",
                                              //          "country_code": "IN",
                                              //          "postal_code": "11001",
                                              //          "phone": "+00000000",
                                              //          "state": "Texas"
                                              //       },
                                            }

                                          }

                                        ],
                                        note: "Contact us for any questions on your order.",
                                        onSuccess: (Map params) async {
                                          print("onSuccess: $params");
                                          //    shoplayoutcubit.get(context).orderindatabase(params);
                                              ;
                                          //           Map<String, dynamic>.from(snapshot.params as Map);
                                          Map<String, dynamic> convertMap(Map<dynamic, dynamic> map) {
                                            map.forEach((key, value) {
                                              if (value is Map) {
                                                // it's a map, process it
                                                value = convertMap(value);
                                              }
                                            });
                                            // use .from to ensure the keys are Strings
                                            return Map<String, dynamic>.from(map);
                                            // more explicit alternative way:
                                            // return Map.fromEntries(map.entries.map((entry) => MapEntry(entry.key.toString(), entry.value)));
                                          }
                                          Map<String, dynamic> result = convertMap(params);
// example nested map with dynamic value
// convert the example map
                                      shoplayoutcubit.get(context).orderindatabase(result);
                                          print(result);
                                        },
                                        onError: (error) {
                                          print("onError: $error");
                                          print(shoplayoutcubit.get(context).pricee[0]);
                                          print(shoplayoutcubit.get(context).pro[0]);

                                          Navigator.pop(context);
                                        },
                                        onCancel: () {
                                          print('cancelled:');
                                        },
                                      ),
                                ));





                              },
                              child: Text('order now',
                                style: TextStyle(color: Colors.white),


                              ),
                              style:  TextButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                                foregroundColor: Colors.white,
                                shape: const BeveledRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(1),
                                  ),
                                ),
                              ),
                            )),
                      ),

                  ],
                ),
                fallback: (context)=>Center(child: CircularProgressIndicator(color: Colors.deepOrange,)),
              ),

            );

          },
        );

      },

    );
  }
  Widget builditemart(cartgetmodel mode,index,q,context,state)=>Container(
    height: 120,
    child: Row(

      children: [

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.deepOrange
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Image(image: NetworkImage('${mode.data?.cartItems![index].product?.image}',

            ),


            ),
          ),
        ),


        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text('${mode.data?.cartItems![index].product?.name}',overflow: TextOverflow.ellipsis),
              ConditionalBuilder(
                condition: shoplayoutcubit.get(context).pricee.length>0,
                builder: (context)=> Text('${shoplayoutcubit.get(context).pricee[index]}'),
                fallback: (context)=>Text("0"),

              ),
            ],
          ),
        ),
        Spacer(),
        ConditionalBuilder(
          condition: shoplayoutcubit.get(context).pro.length>0,
          builder: (context)=> Text('${shoplayoutcubit.get(context).pro[index]}'),
          fallback: (context)=>Text("0"),

        ),
        IconButton(onPressed: (){

          // shoplayoutcubit.get(context).addcart(id: mode.data?.cartItems![index].product?.id,idex: index);
          // shoplayoutcubit.get(context).deletequantity(index: mode.data?.cartItems![index].product?.id ,idex: index);
          shoplayoutcubit.get(context).deletecart(id:  mode.data?.cartItems![index].product?.id, idex: index);
          shoplayoutcubit.get(context).t=(shoplayoutcubit.get(context).t-shoplayoutcubit.get(context).pricee[index]);


          // print(shoplayoutcubit.get(context).price);
          if(state is shopcartsucessstateshop){
            print("okkkk");


          }

        }, icon: Icon(
          Icons.delete,
        ),
        ),

      ],
    ),
  );
}
