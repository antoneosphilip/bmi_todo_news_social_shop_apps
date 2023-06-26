import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Network/login/login.dart';
import 'package:shopapp/Network/remote/diohelper.dart';
import 'package:shopapp/modules/shop_app/model/fav-model2.dart';
import 'package:shopapp/modules/shop_app/search-scrren/cubit/states.dart';
import 'package:shopapp/modules/shop_app/search-scrren/search-model/search-model.dart';
import 'package:shopapp/shared/styles/styles.dart';

class searchcubit extends Cubit<shopsearchstates>{
  searchcubit():super(shopsearchintialstate());
static searchcubit get(context)=>BlocProvider.of(context);

  Map<int,bool>? faveorite={};
  searchmodel? Smodel;
void search(String text){
  emit(shopsearchloadingstate());
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
    emit(shopsearchsuccessstate());
  }).catchError((erroe){
    print(erroe);
    emit(shopsearcherrorstate());

  });
}
  void changefav(int productid){
    faveorite![productid]=!faveorite![productid]!;
    emit(shopsearchfavsucessstate());

    Diohelper.putdata(
        url: Fav,
        token: token,
        data: {
          'product_id':productid,
        })?.then((value) {
      Smodel= searchmodel.fromjson(value?.data);
      if(Smodel?.status==false){
        faveorite![productid]=!faveorite![productid]!;


      }else{
        faveoritedata();
      }
      emit(shopsearchfavsucessstate());
    }).catchError((error){
      print(error);
      faveorite![productid]=!faveorite![productid]!;

      emit(shopsearcherrorstate());
    });
  }

  faveoritesmodel? modelfaveoritee;

  void faveoritedata(){
    emit(faveoritemodelloadingsearch());
    Diohelper.getdata(
      url: Fav,
      token: token,
    )!.then((value) {
      modelfaveoritee=faveoritesmodel.fromjson(value?.data);
      print(modelfaveoritee?.data?.data![0].product?.image.toString());
      emit(faveoritemodelsucesssearch());
    }).catchError((error){
      print(error);
      emit(faveoritemodelerroesearch());

    });
  }



}

