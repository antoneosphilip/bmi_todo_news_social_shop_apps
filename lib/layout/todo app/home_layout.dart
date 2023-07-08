// ignore: invalid_language_version_override

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shopapp/cubit/cubit.dart';
import 'package:shopapp/cubit/states.dart';

import 'package:sqflite/sqflite.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';

 class homelayout extends StatelessWidget {
  @override


  final scaffoldkey = GlobalKey<ScaffoldState>();

  final formkey = GlobalKey<FormState>();

  var controler = TextEditingController();

  var titlecontroler = TextEditingController();

  var datecontroler = TextEditingController();

  homelayout({key});
  @override


  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) =>Appcubit()..createdatabase(),
      child:BlocConsumer<Appcubit,Appstates>(
listener: (context,state){
  if(state is insertdatabasestate){
    Navigator.pop(context);
  }
},
        builder: (context,state){
  return Scaffold(

      key: scaffoldkey,
      appBar: AppBar(
        title: Text(
          Appcubit.get(context).texts[Appcubit.get(context).index],
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async
        {
          if (Appcubit.get(context).x == true) {
            if (formkey.currentState!.validate()) {
Appcubit.get(context).insertdatabase(
    title: titlecontroler.text,
    time: controler.text,
    date: datecontroler.text,
);


            };
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
              Appcubit.get(context).changefloating(
                  y: false,
                  ic: Icons.edit
              );


            });


            Appcubit.get(context).changefloating(
                y: true,
                ic: Icons.add,
            );



          };

        },
        child: Icon(Appcubit.get(context).iconn),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: Appcubit.get(context).index,
          onTap: (ind) {
            Appcubit.get(context).changebutton(ind);
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
      body:
      ConditionalBuilder(
        condition: true,
        builder: (context) => Appcubit.get(context).Screens[Appcubit.get(context).index],
        fallback: (context) => Center(child: CircularProgressIndicator()),

      ));
        },
      ),



    );


  }

  Future<String> getname() async
  {
    return "A";
  }




// );

}






