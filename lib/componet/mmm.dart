
import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'dart:convert';

import 'package:shopapp/cubit/cubit.dart';
import 'package:shopapp/modules/news_app/webview/webview.dart';
final formkey = GlobalKey<FormState>();


Widget builderitem(Map model,context)=>Dismissible(
  key:Key(model['id'].toString()),
  onDismissed: (direction){
Appcubit.get(context).deletedata(id: model['id']);
  },
  child:Padding(

  padding: const EdgeInsets.all(10.0),

  child: Row(

  children: [

  CircleAvatar(

  radius: 40,

  child: Text(

  "${model['time']}",

  style: TextStyle(

  fontSize: 20,

  fontWeight: FontWeight.bold,

  ),

  ),

  ),

  SizedBox(

  width: 10,

  ),

  Expanded(

    child:   Column(



    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    "${model['title']}",
    style: TextStyle(
    fontSize: 20,



    fontWeight: FontWeight.bold



    ),



    ),



    Text(



    "${model['date']}",



    style: TextStyle(



    fontSize: 15,



    color: Colors.grey,



    ),



    ),







    ],



    ),

  ),

    SizedBox(

      width: 10,

    ),

    IconButton(

      onPressed: () {

        Appcubit.get(context).ubdatedata(statue: 'done', id: model['id'],

        );



      },

        icon:Icon(

            Icons.check_circle

        ),

     color: Colors.green,

    ),

    SizedBox(

      width: 10,

    ),

    IconButton(

      onPressed: (){

        Appcubit.get(context).ubdatedata(statue: 'archived', id: model['id'],

        );

      },



      icon:Icon(

          Icons.archive,

      ),

      color: Colors.black54,

    ),



  ],

  ),

  ),
);
Widget conditinitem({required tasks})=>ConditionalBuilder(
  condition: tasks.length>0,
  builder:(context)=> ListView.separated(
    itemBuilder: (context, index) => builderitem(tasks[index],context),
    separatorBuilder: (context, index) =>seprator(),

    itemCount: tasks.length,
  ),
  fallback: (context)=>Center(
    child: Column(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100,
          color: Colors.grey,
        ),
        Text(
          "No Tasks Yet,Please Add Some Tasks",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey
          ),
        ),
      ],
    ),
  ),
);
Widget builddio(articles,context)=> InkWell(
  onTap: (){
    Navigator.push(context, MaterialPageRoute(
      builder:(context)=>web( articles['url']),
    ));
      
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        Container(
  
          width: 120,
  
          height: 120,
  
          decoration: BoxDecoration(
  
            borderRadius: BorderRadius.circular(15),
  
  image:DecorationImage(image: NetworkImage("${articles['urlToImage']}"),
  
    fit: BoxFit.cover,
  
  ),
  
          ),
  
    ),
  
       SizedBox(width: 20,),
  
        Expanded(
  
          child: Container(
  
            height: 120,
  
            child: Column(
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              children: [
  
                Expanded(
  
                  child: Text(
  
                    "${articles['title']}",
  
                    maxLines: 3,
  
                    overflow: TextOverflow.ellipsis,
  
                    style: Theme.of(context).textTheme.bodyText1,
  
                  ),
  
                ),
  
                Text(
  
                  "${articles['publishedAt']}",
  
                  style: TextStyle(
  
                    color: Colors.grey,
  
                  ),
  
                ),
  
              ],
  
            ),
  
          ),
  
        ),
  
  
  
      ],
  
    ),
  
  ),
);
Widget seprator()=>Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);
Widget defaulttext(
{
  required TextEditingController controller,
   required TextInputType type,
  required IconData prefix,
  bool isbass=false,
   required String text,
  VoidCallback? onpressed,
 IconData? sufficon,
  required Function validate,
  Function? onsubmited,
  Function? onchanged,

}
    )=> TextFormField(
  onFieldSubmitted: (value) {
    onsubmited!(value);
  },

  showCursor: true,

  controller: controller,
  keyboardType: type,
      validator: (value) {
    validate;
    },

  obscureText: isbass,

  decoration:  InputDecoration(

    labelText: text,
    labelStyle: TextStyle(color: Colors.black),
    prefixIcon: Icon(

prefix,
      color: Colors.black,
    ),
    suffixIcon: IconButton(
        onPressed:onpressed,

      icon: Icon(
sufficon
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),

  borderSide: BorderSide(
    color: Colors.deepOrange,
    width: 2
  ),
),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
        color: Colors.deepOrange,
        width: 2.0,
      ),
    ),

  ),

);
Color? color;
void toast({
  required String text,
  required toastchoose choose,
}){

  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: colorchosse(choose: choose),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
enum toastchoose{warning,success,error}
Color? colorchosse({required toastchoose choose}){
  switch(choose){
    case toastchoose.warning:
    color=Colors.amber;
    break;
    case toastchoose.success:
      color=Colors.green;
      break;
    case toastchoose.error:
      color=Colors.red;
      break;
  }
  return color;

}
// body: TextButton(onPressed: (){
// shared.clear(key: "token").then((value) {
// Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=>loginshopscreen()), (route) => false,);
//
// });
// }, child:Text("sign out")),




