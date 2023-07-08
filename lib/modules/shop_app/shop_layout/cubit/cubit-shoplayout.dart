
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp/Network/login/login.dart';
import 'package:shopapp/Network/remote/diohelper.dart';
import 'package:shopapp/componet/main.dart';
import 'package:shopapp/model/model.dart';
import 'package:shopapp/modules/shop_app/categories-tscrren/categories.dart';
import 'package:shopapp/modules/shop_app/faveorites-scrren/faveorites.dart';
import 'package:shopapp/modules/shop_app/model/cart-model.dart';
import 'package:shopapp/modules/shop_app/model/cartgetmodel.dart';
import 'package:shopapp/modules/shop_app/model/category-model.dart';
import 'package:shopapp/modules/shop_app/model/fav-model2.dart';
import 'package:shopapp/modules/shop_app/model/favmodel.dart';
import 'package:shopapp/modules/shop_app/model/homemodel.dart';
import 'package:shopapp/modules/shop_app/model/paypal-modek.dart';
import 'package:shopapp/modules/shop_app/productscrren/productscreen.dart';
import 'package:shopapp/modules/shop_app/search-scrren/search-model/search-model.dart';
import 'package:shopapp/modules/shop_app/settings-scrren/settings.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/model.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/states.dart';
import 'package:shopapp/modules/social-app/social-logins-creen/cubit/cubit.dart';
import 'package:shopapp/shared/styles/styles.dart';

import '../../../../componet/mmm.dart';



class shoplayoutcubit extends Cubit<shoplayoutstates>{
  static shoplayoutcubit get(context)=>BlocProvider.of(context);
  shoplayoutcubit():super(shopintialstate());
  int currentindex=0;
  bool faveorites=true;
  List<IconData>?iconn;
  IconData ?ic;
  Map<int,bool>? faveorite={};
  int pm=1;


  List<Widget> screens=[
    productscreen(),
    categoriesscreen(),
    faveoritesscreen(),
    settingsscreen(),
  ];
  void changeborromnav(int index){
    currentindex=index;
    emit(changebottonnavstate());

  }
  homemodel? model;

  void homedata(){
    emit(shoploading());

    Diohelper.getdata(url: HOME,token: token)!.then((value) {
      model=homemodel.fromjson(value?.data);
      print(model?.data?.banners?.map((e) => {
        e.image,
      }).toList());
      print(model?.status);
      model!.data!.products!.forEach((element) {
        faveorite?.addAll({
          element.id!:element.in_favorites!,
        });
      });

      emit(shopsuccess());
    }).catchError((error){
      print(error);
      emit(shoperroe());

    });
  }
  categorymodel? modelcategory;

  void categorydata(){
    emit(shoploading());

    Diohelper.getdata(url: Category,)!.then((value) {
      modelcategory=categorymodel.fromjson(value?.data);
      emit(categorymodelsucess());
    }).catchError((error){
      print(error);
      emit(categorymodelerror());

    });
  }
  favmodel? fav;
  void changefav(int productid){
    faveorite![productid]=!faveorite![productid]!;
    emit(shopfavsuccess1());
    print(faveorite![productid]);

    Diohelper.putdata(
        url: Fav,
        token: token

        ,
        data: {
          'product_id':productid,
        })?.then((value) {
      fav= favmodel.fromjson(value?.data);
      if(fav?.status==false){
        faveorite![productid]=!faveorite![productid]!;

      }else{
        faveoritedata();
      }
      emit(shopfavsuccess(fav!));
    }).catchError((error){
      print(error);
      faveorite![productid]=!faveorite![productid]!;

      emit(shoperroe());
    });
  }

  faveoritesmodel? modelfaveorite;

  void faveoritedata(){
    emit(faveoritemodelloading());
    Diohelper.getdata(
      url: Fav,
      token: token,
    )!.then((value) {
      modelfaveorite=faveoritesmodel.fromjson(value?.data);
      print('token is');
      print(token.toString());
      emit(faveoritemodelsucess());
    }).catchError((error){
      print(error);
      emit(faveoritemodelerror());

    });
  }
  shoploginmodel? modelprofile;

  void profiledata(){
    emit(profilemodelloading());
    Diohelper.getdata(
      url: PROFILE,
      token: token,
    )!.then((value) {
      modelprofile=shoploginmodel.fromjson(value?.data);
      print(modelprofile?.data!.image.toString());
      emit(profilemodelsucess());
    }).catchError((error){
      print(error);
      emit(profilemodelerror());

    });
  }

  void updateprofiledata({
    required name,
    required email,
    required phone,
  }){
    emit(updateprofilemodelloading());
    Diohelper.postdata(
        url: updatePROFILE,
        token: token,
        data: {
          'name':name,
          'email':email,
          'phone':phone
        }

    )!.then((value) {
      modelprofile=shoploginmodel.fromjson(value?.data);
      print(modelprofile?.message.toString());
      emit(updateprofilemodelsucess(modelprofile!));


    }).catchError((error){
      print(error);
      emit(updateprofilemodelerror());

    });
  }


  void changeiconfavorite(){

    emit(changeiconfavorie());

  }
  searchmodel? Smodel;
  void search(String text){
    emit(shopsearchloadingstateshop());
    Diohelper.putdata(
      url: SEARCH,
      data: {
        'text':text,
      },
      token: token,
    )?.then((value) {
      Smodel=searchmodel.fromjson(value?.data);
      print(Smodel!.data!.data![0].id);

      emit(shopsearchsucessstateshop());
    }).catchError((erroe){
      print(erroe);
      emit(shopsearcherroestateshop());

    });
  }

  int? price;
  List<int> pricee=[];
  int y=0;
  void add({required index}){

    pm++;
    price=modelfaveorite?.data?.data![index].product!.price as int?;

    price=price!*pm!;

    print("pricee");



    emit(shopaddstateshop());

  }



  void remove({required index}){
    if(pm>0){
      pm=pm-1;
      price=(price!-(modelfaveorite?.data?.data![index].product!.price!)).toInt();
      y=(y-modelfaveorite?.data?.data![index].product!.price!).toInt();
      print(y);
      print(price);
      emit(shopremovetateshop());
      print(pm);
    }


  }
  cartmodel? cmodel;
  void addcart({required id,required idex}){
    emit(cartsendemodelloading());
    Diohelper.putdata(
      url: cart,

      data: {
        'product_id':id,

      },
      token: token,
    )?.then((value) {
      print("u=iddddd");
      print(id);
      cmodel= cartmodel.fromJson(value?.data);
      print("quuuuu");
      cmodel?.data?.product?.id;
print(cmodel?.message);
      getcartmodel();


      emit(shopcartsucessstateshop());

    }).catchError((error){
      print(error.toString());
      emit(shopcarterroestateshop());
    });
  }
  int h=0;
  cartgetmodel? cartgetmodel2;
  void getcartmodel(){
    emit(cartemodelloading());
    Diohelper.getdata(
      url: cart,

      token: token,
    )?.then((value) {
print(value?.data);
      cartgetmodel2=  cartgetmodel.fromJson(value?.data);
print("valllllll");

print(cartgetmodel2?.data?.cartItems![0].product?.name);
      // for(int i=0;i<cartgetmodel2!.data!.cartItems!.length!;i++){
      //
      //
      //
      // }
// if(pricee.length==0&&pro.length==0){
//   cartgetmodel2?.data?.cartItems=[];
// }
      print('nameeeeeeee');
      print(cartgetmodel2!.data!.subTotal);
      //print(cartgetmodel2?.data?.subTotal);
      emit(shopcartgetsucessstateshop());

    }).catchError((error){
      print(error.toString());
      emit(shopcartgeterroestateshop());
    });

  }


  void setmodel({required index,required quantity,required idex}){
    FirebaseFirestore.instance.collection('product').doc('${index.toString()}').set(

        {
          'quantity':quantity,
          'price':price,
          //'total price':cartgetmodel2!.data!.subTotal,


        }

    ).then((value) {

      emit(setquantitysucccess());
    }).catchError((error){
      emit(setquantityerror());


    });


  }
//   void setmodel({required index,required quantity}){
//     FirebaseFirestore.instance.collection('product').add({
//       'quantity':quantity
//     }).then((value) {
//
//       emit(setquantitysucccess());
//     }).catchError((error){
//       emit(setquantityerror());
//
//
//     });
//
//
//   }

  modelquantity? qu;
  List<int> pro=[];
// void getqu({required index}){
//   FirebaseFirestore.instance.collection('product').doc('${index.toString()}').snapshots().listen((event) {
//     qu=modelquantity.fromJson(event.data()!);
//     pro.add(qu!.quantity!);
//     print(qu?.quantity);
//     emit(getquantitysucccess());
//
//   });
//
// }
  int g=0;
  int t=0;
  int q=0;
  void getqu({required index}){
    // price=0;
    FirebaseFirestore.instance.collection('product').doc('${index.toString()}').get().then((value) {

      qu=modelquantity.fromjson(value!.data()!);
      print("llllllll");
   //   print(qu?.price);
      pro.add(qu!.quantity!);


      pricee.add(qu!.price!);
      print(pro[0]);

      t=0;

      for(int i=0;i<pricee.length;i++){
        t=pricee[i]+t;

      }
      for(int i=0;i<pro.length;i++){
        q=pro[i]+q;

      }
      print("toooo");
      print(pricee);


    //  g=qu!.total!+g;
      //  print(g);
      emit(getquantitysucccess());

    }).catchError((error){
      emit(getquantityerror());
    });
  }
  void deletequantity({required index,required idex}){
    emit(deleteloading());
    // pro.removeAt(idex);
    // pricee.removeAt(idex);
    print(pricee);
    FirebaseFirestore.instance.collection('product').doc('${index.toString()}').delete().then((value) {
      print("okkkk");

      // emit(deleteindexsucccess());
      print(pricee);


      pricee.removeAt(idex);
      pro.removeAt(idex);
      emit(deletequantitysucccess());

    }).catchError((error){
      emit(deletequantityerror());
    });
  }
// FutureBuilder run(){
//
//   return new FutureBuilder<SharedPreferences>(
//     future: SharedPreferences.getInstance(),
//     builder:
//         (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
//       switch (snapshot.connectionState) {
//         case ConnectionState.none:
//         case ConnectionState.waiting:
//           return new CircularProgressIndicator();
//         default:
//           if (!snapshot.hasError) {
//       ("Return a welcome screen");
//       return snapshot.data?.getBool("welcome") != null
//       ? new Text("hh")
//           : new CircularProgressIndicator();
//       } else {
//       return new Text('${ snapshot.error}');
//       }
//     }
//     },
//   );
//
// }
//   void createorder(){
//     Diohelper2.putdata(
//       url: order,
//       data: {
//
//
//         "intent": "CAPTURE",
//         "purchase_units": [
//           {
//             "items": [
//               {
//                 "name": "T-Shirt",
//                 "description": "Green XL",
//                 "quantity": "1",
//                 "unit_amount": {
//                   "currency_code": "USD",
//                   "value": "200.00"
//                 }
//               }
//             ],
//             "amount": {
//               "currency_code": "USD",
//               "value": "200.00",
//               "breakdown": {
//                 "item_total": {
//                   "currency_code": "USD",
//                   "value": "200.00"
//                 }
//               }
//             }
//           }
//         ],
//         "application_context": {
//           "return_url": "https://example.com/return",
//           "cancel_url": "https://example.com/cancel"
//         }
//
//       },
//       token: token,
//     )?.then((value) {
//       print(value?.statusCode);
//     });
//
//
//   }
//   List<paypalmodel> paypa=[];
//
//   void paypal({required context,index}){
//     paypalmodel pay=paypalmodel(
//       name: cartgetmodel2!.data!.cartItems![index].product!.name,
//       quantity:( pro[index]),
//       currency: "us",
//       price: pricee[index],
//
//     );
//     paypa.add(pay);
//     print("kkkkkkkkkkkk");
//     print(paypa[0].price);
//
//
//   }
//   void map(Map params){
//
//
//   }
  Map<String, dynamic> dynamicMapToString(Map<dynamic, dynamic> data) {
    List<dynamic> _convertList(List<dynamic> src) {
      List<dynamic> dst = [];
      for (int i = 0; i < src.length; ++i) {
        if (src[i] is Map<dynamic, dynamic>) {
          dst.add(dynamicMapToString(src[i]));
        } else if (src[i] is List<dynamic>) {
          dst.add(_convertList(src[i]));
        } else {
          dst.add(src[i]);
        }
      }
      return dst;
    }

    Map<String, dynamic> retval = {};
    for (dynamic key in data.keys) {
      if (data[key] is Map<dynamic, dynamic>) {
        retval[key.toString()] = dynamicMapToString(data[key]);
      } else if (data[key] is List<dynamic>) {
        retval[key.toString()] = _convertList(data[key]);
      } else {
        retval[key.toString()] = data[key];
      }
    }

    return retval;

  }
  //{error: false,
  // message: Success,
  // data: {id: PAYID-MSUZA4Y19C38913BR512893D, intent: sale, state: approved, cart: 48S43735DL284183H, payer: {payment_method: paypal, status: VERIFIED, payer_info:
  // {email: sb-cf19u26547196@personal.example.com, first_name: John, last_name: Doe, payer_id: P6UKJW5XLLPYW,
  // shipping_address: {recipient_name: John Doe, line1: 1 Main St, city: San Jose, state: CA, postal_code: 95131, country_code: US}, country_code: US}},
  // transactions: [{amount: {total: 225.00, currency: USD, details: {subtotal: 225.00, shipping: 0.00, insurance: 0.00, handling_fee: 0.00, shipping_discount: 0.00, discount: 0.00}}, payee: {merchant_id: ABN8E6UTUYNU2, email: sb-mxppt26330664@business.example.com},
  // description: The payment transaction description., item_list: {items: [{name: Front Patch Pocket Long Sleeve Shirt - Dark Olive, price: 225.00,
  // currency: USD, tax: 0.00, quantity: 1, image_url: }],
  // shipping_address: {recipient_name: John Doe,
  // line1: 1 Main St, city: San Jose, state: CA, postal_code:
  void orderindatabase(Map<String,dynamic> a){

    FirebaseFirestore.instance.collection('orderdetails').add(a).then((value) {

      print(value);
    });

  }
}

