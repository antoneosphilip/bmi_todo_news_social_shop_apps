
import 'dart:convert';
import 'dart:ffi';

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
  Map<int,bool>? bottom={};

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
        bottom?.addAll({
          element.id!:element.in_cart!,
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
    print(productid);
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
    price=modelfaveorite?.data?.data![index].product!.price!.round()!;

    price=price!*pm!;

    print("pricee");



    emit(shopaddstateshop());

  }



  void remove({required index}){
    if(pm>0){
      pm=pm-1;
      price=(price!-(modelfaveorite?.data?.data![index].product!.price!)!.toDouble()).toInt();
      y=(y-(modelfaveorite?.data?.data![index].product!.price!)!.toDouble()).toInt();
      print(y);
      print(price);
      emit(shopremovetateshop());
      print(pm);
    }


  }
  cartmodel? cmodel;
  void addcart({required id,required idex}){
bottom![id]=!bottom![id]!;
    emit(cartsendemodelloading());
    Diohelper.putdata(
      url: cart,

      data: {
        'product_id':id,

      },
      token: token,
    )?.then((value) {
      print("object");

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
  }

  void orderindatabase(Map<String,dynamic> data){

    FirebaseFirestore.instance.collection('orderdetails').add(data).then((value) {
emit(orderindatabasesuccess());
      print(value);
    }).catchError((error){
      emit(orderindatabaseerror());

    });

  }
  bool k=false;
  void changek(){
    k=true;
    print(k);
    emit(changk());
  }
  void deletecart({required id,required idex}){
    bottom![id]=!bottom![id]!;
    emit(cartdeleteemodelloading());
    Diohelper.putdata(
      url: cart,

      data: {
        'product_id':id,

      },
      token: token,
    )?.then((value) {

      FirebaseFirestore.instance.collection('product').doc('${idex.toString()}').delete().then((value) {
        print("okkkk");

        // emit(deleteindexsucccess());
        print(pricee);


        pricee.removeAt(idex);
        pro.removeAt(idex);
        emit(deletequantitysucccess());

      }).catchError((error){
        emit(deletequantityerror());
      });

      getcartmodel();



      emit(shopcartdeletesucessstateshop());

    }).catchError((error){
      print(error.toString());
      emit(shopcartdeleterroestateshop());
    });
  }

}

