
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Network/remote/diohelper.dart';
import 'package:shopapp/cubit/states.dart';
import 'package:shopapp/modules/todo_app/archived%20tasks/Archived%20tasks-screen.dart';
import 'package:shopapp/modules/todo_app/done%20tasks/Done%20tasks-screen.dart';
import 'package:shopapp/modules/todo_app/new%20tasks/new%20tasks-screen.dart';

import 'package:sqflite/sqflite.dart';



class Appcubit extends Cubit<Appstates>{
  Appcubit():super(Appintialstaes());

  static Appcubit get(context)=>BlocProvider.of<Appcubit>(context);
  var index=0;

  List<Widget> Screens=[
newtasksscreen(),
    donetasksscreen(),
    archivedtasksscreen(),

  ];

  List<String> texts=[
    "new tasks",
    "done tasks",
    "archive tasks",
  ];
void changebutton(int ind){
  index=ind;
  emit(Appchangestaes());
}

var database;
  List<Map> newtasks=[];
  List<Map> donetasks=[];
  List<Map> archivedtasks=[];

  void createdatabase()
  {
 openDatabase(
        "todoapp.db",
        version: 1,
        onCreate: (database,version) {
          print("create database");
          database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,statue TEXT)').then((value) {
            print("create table");
          }).catchError((error){
          });

        },
        onOpen: (database){
          Getdatafromdatabase(database);
          print("open database");
        }
    ).then((value) {
      database=value;
      emit(Createdatabasestate());
 });

  }

   void insertdatabase({
    required String title,
    required String time,
    required String date,
  })  {
      database.transaction((txn) async {
      txn.rawInsert("INSERT INTO tasks(title,date,time,statue ) VALUES('$title','$date','$time','new')")
          .then((value){
            emit(insertdatabasestate());
            Getdatafromdatabase(database);
        print("$value insert successfly");
      }).catchError((error){});
    });
  }
 Getdatafromdatabase(database){
   newtasks=[];
   donetasks=[];
    archivedtasks=[];


 database.rawQuery('SELECT * FROM tasks').then((value) {
value.forEach((element){
 if(element['statue']=='new'){
   newtasks.add(element);
 }

  else  if(
 element['statue']=='done'
 )
  {
   donetasks.add(element);
 }
else{
     archivedtasks.add(element);
 }
print(element['statue']);
  });

   emit(getdatabasestate());

 });
  }

  void deletedata({

    required int id,
  }
      )async
  {
    database. rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value)
    {
      Getdatafromdatabase(database);
      emit(deletedatabasestate());

    }

    );}
void ubdatedata({
  required String statue,
  required int id,
}
     )async
{
   database.rawUpdate(
        'UPDATE tasks SET statue = ? WHERE id = ?',
        ['$statue', id]
      ).then((value)
    {
      Getdatafromdatabase(database);
      emit(updatedatabasestate());

    }
   );
  }
  bool x=false;
  IconData iconn=Icons.edit;
  void changefloating({
  required bool y,
 required IconData ic,
}
)
  {
x=y;
iconn=ic;
      emit(Appchangesbotton());
  }

  bool light=false;

  void changecolormode({bool? dark}){
    if(dark!=null){
      light=dark;
      emit(changecolorstates());
    }
    else{
      light = !light;
      shared.putbooldata(key: 'light', value: light).then((value) {
        emit(changecolorstates());
      });
    }
  }
}
