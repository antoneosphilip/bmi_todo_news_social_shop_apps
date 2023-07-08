// ignore: invalid_language_version_override
import 'dart:developer';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shopapp/modules/todo_app/archived%20tasks/Archived%20tasks-screen.dart';
import 'package:shopapp/modules/todo_app/done%20tasks/Done%20tasks-screen.dart';
import 'package:shopapp/modules/todo_app/new%20tasks/new%20tasks-screen.dart';

import 'package:sqflite/sqflite.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';

class homel extends StatefulWidget {
  @override
  State<homel> createState() => _homelayoutState();
}

class _homelayoutState extends State<homel> {
  final scaffoldkey = GlobalKey<ScaffoldState>();

  final formkey = GlobalKey<FormState>();

  var controler = TextEditingController();

  var titlecontroler = TextEditingController();

  var datecontroler = TextEditingController();
  var index = 0;

  IconData iconn = Icons.edit;
  bool x = false;

  void changebutton(int ind) {
    index = ind;
  }


  List<Widget> Screens = [
    newtasksscreen(),
    donetasksscreen(),
    archivedtasksscreen(),
  ];

  List<String> texts = [
    "new tasks",
    "done tasks",
    "archive tasks",
  ];
  var database;
  @override
  void initState() {
    createdatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      key: scaffoldkey,
      appBar: AppBar(
        title: Text(
          texts[index],
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async
        {
          if (x == true) {
            if (formkey.currentState!.validate()) {
              insertdatabase(
                title: titlecontroler.text,
                time: controler.text,
                date: datecontroler.text,
              ).then((value) {
                Navigator.pop(context);
                setState(() {
                  iconn=Icons.edit;
                });

              });

              x = false;
            }
          }

          else {
            scaffoldkey.currentState
                ?.showBottomSheet
              (
                  (context) =>
                  Container(
                    color: Colors.grey[200],
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: titlecontroler,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "task cann't be empty";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Task title",
                              prefixIcon: Icon(
                                Icons.title,
                              ),


                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(

                            controller: controler,
                            keyboardType: TextInputType.datetime,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "time cann't be empty";
                              }

                              return null;
                            },
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),

                              ).then((value) {
                                controler.text = value!.format(context);
                              });
                            },
                            decoration: InputDecoration(
                              labelText: "Task time",
                              prefixIcon: Icon(
                                Icons.watch_later_outlined,
                              ),


                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(

                            controller: datecontroler,
                            keyboardType: TextInputType.datetime,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "datetime cann't be empty";
                              }

                              return null;
                            },
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              ).then((value) =>
                              {
                                datecontroler.text =
                                    DateFormat.yMMMd().format(value!),
                              });
                            },
                            decoration: InputDecoration(
                              labelText: "Task date",
                              prefixIcon: Icon(
                                Icons.calendar_today,
                              ),


                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),


            )
                .closed
                .then((value) {
              setState(() {
                x=false;
                iconn= Icons.edit;
              });


            });
            setState(() {

              iconn= Icons.add;
            });
            x= true;

          };

        },
        child: Icon(iconn),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (ind) {
            changebutton(ind);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
              ),
              label: "Menu",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.check_circle_outline,
              ),
              label: "Done",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.archive_outlined,
              ),
              label: "Archived",
            ),
          ]

      ),
      body: ConditionalBuilder(
        condition: true,
        builder: (context) => Screens[index],
        fallback: (context) => Center(child: CircularProgressIndicator()),

      ),
    );
  }

  Future<String> getname() async
  {
    return "A";
  }



  void createdatabase() async
  {
    database = await openDatabase(
        "todoo.db",
        version: 1,
        onCreate: (database, version) {
          print("create database");
          database.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT)')
              .then((value) {
            print("create table");
          }).catchError((error) {});
        },
        onOpen: (database) {
          Getdatafromdatabase(database).then((value) {

            setState(() {
              var tasks = value;
              print(tasks);

            });
          });
          print("open database");
        }
    );

  }

  Future insertdatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    return await database.transaction((txn) async {
      txn.rawInsert("INSERT INTO tasks(title,date,time) VALUES('$title','$date','$time')")
          .then((value){
        print("$value insert successfly");
      }).catchError((error){});
    });
  }

  Future <List<Map>> Getdatafromdatabase(database) async{
    return await database.rawQuery('SELECT * FROM tasks');
  }
}



