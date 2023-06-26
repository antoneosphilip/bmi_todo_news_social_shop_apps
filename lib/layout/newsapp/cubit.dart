
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Network/remote/diohelper.dart';

import 'package:shopapp/layout/newsapp/states.dart';
import 'package:shopapp/modules/news_app/business/business_screen.dart';
import 'package:shopapp/modules/news_app/science/science_screen.dart';
import 'package:shopapp/modules/news_app/sports/sports_screen.dart';


class newcubit extends Cubit<newsstates>{
  newcubit():super(intialstate());
  static newcubit get(context)=>BlocProvider.of<newcubit>(context);

int currentindex=0;
List<BottomNavigationBarItem> bottomitem=[
  BottomNavigationBarItem(
      icon: Icon(Icons.business),
    label: "Business",
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.sports),
    label: "Sports",
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.science),
    label: "Scince",
  ),



];
  List<Widget> screens=[
businessscreen(),
    sportsscreen(),
sciencesscreen(),
  ];


void changebottom(int index){
  currentindex=index;
  if(currentindex==1)
    getdatasports();
  if(currentindex==2)
    getdatascience();
  emit(changebottomnav());
}
List<dynamic> business=[];
void getdata(){
  Diohelper.getdata
    (
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category':'business',
        'apiKey':'d6f8b04d316c418197ff82581bd27fc1',
      }
  )?.then((value) {
    business=value?.data['articles'];
    emit(getdatasucess());
  }).catchError((error){
print(error.toString());
emit(getdataerror(error.toString()));
  });
}

  List<dynamic> science=[];
  void getdatascience(){
if(science.length==0){
  Diohelper.getdata
    (
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category':'science',
        'apiKey':'d6f8b04d316c418197ff82581bd27fc1',
      }
  )?.then((value) {
    science=value?.data['articles'];
    emit(getdatasciencesucess());
  }).catchError((error){
    print(error.toString());
    emit(getdatascienceerror(error.toString()));
  });
}else{
  emit(getdatasciencesucess());

}

  }

  List<dynamic> sports=[];
  void getdatasports(){
    if(sports.length==0){
      Diohelper.getdata
        (
          url: 'v2/top-headlines',
          query: {
            'country': 'us',
            'category':'sports',
            'apiKey':'d6f8b04d316c418197ff82581bd27fc1',
          }
      )?.then((value) {
        sports=value?.data['articles'];
        emit(getdatasportssucess());
      }).catchError((error){
        print(error.toString());
        emit(getdatasportserror(error.toString()));
      });
    }else{
      emit(getdatasportssucess());

    }

  }
  List<dynamic> search=[];
  void getdsearch(String value){
      Diohelper.getdata
        (
          url: 'v2/everything',
          query: {
            'q': '$value',
            'apiKey':'d6f8b04d316c418197ff82581bd27fc1',
          }
      )?.then((value) {
        search=value?.data['articles'];
        emit(getdatasearchssucess());
      }).catchError((error){
        print(error.toString());
        emit(getdatasearcherror(error.toString()));
      });



  }


}