import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Network/login/login.dart';
import 'package:shopapp/Network/remote/diohelper.dart';
import 'package:shopapp/model/model.dart';
import 'package:shopapp/modules/shop_app/categories-tscrren/categories.dart';
import 'package:shopapp/modules/shop_app/faveorites-scrren/faveorites.dart';
import 'package:shopapp/modules/shop_app/model/category-model.dart';
import 'package:shopapp/modules/shop_app/model/fav-model2.dart';
import 'package:shopapp/modules/shop_app/model/favmodel.dart';
import 'package:shopapp/modules/shop_app/model/homemodel.dart';
import 'package:shopapp/modules/shop_app/productscrren/productscreen.dart';
import 'package:shopapp/modules/shop_app/search-scrren/search-model/search-model.dart';
import 'package:shopapp/modules/shop_app/settings-scrren/settings.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/states.dart';
import 'package:shopapp/shared/styles/styles.dart';

class shoplayoutcubit extends Cubit<shoplayoutstates>{
  static shoplayoutcubit get(context)=>BlocProvider.of(context);
shoplayoutcubit():super(shopintialstate());
int currentindex=0;
bool faveorites=true;
List<IconData>?iconn;
IconData ?ic;
Map<int,bool>? faveorite={};

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
        token: token,
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
      print(modelfaveorite?.data?.data![0].product?.image.toString());
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
      for(int i=0;i<Smodel!.data!.data!.length!;i++){
        print(
            Smodel!.data!.data![i]!.id!
        );
      }
      emit(shopsearchsucessstateshop());
    }).catchError((erroe){
      print(erroe);
      emit(shopsearcherroestateshop());

    });
  }
}

