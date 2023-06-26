
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Network/remote/diohelper.dart';
import 'package:shopapp/componet/mmm.dart';
import 'package:shopapp/modules/shop_app/cubit/states.dart';
import 'package:shopapp/modules/shop_app/loginshopscreen/loginshop_screen.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/cubit-shoplayout.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/states.dart';

class settingsscreen extends StatelessWidget {
  var nameccontrolle=TextEditingController();
  var emaicontrolle=TextEditingController();
  var phonecontroller=TextEditingController();


  @override
  Widget build(BuildContext context) {
    nameccontrolle.text=shoplayoutcubit.get(context).modelprofile!.data!.name! ;
    emaicontrolle.text=shoplayoutcubit.get(context).modelprofile!.data!.email! ;
    phonecontroller.text=shoplayoutcubit.get(context).modelprofile!.data!.phone! ;


    return BlocConsumer<shoplayoutcubit,shoplayoutstates>(
      listener: (context,state){
        if(state is updateprofilemodelsucess){
          toast(text: state.upmodel.message.toString(), choose: toastchoose.success);
        }


      },
      builder: (context,state){
        return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(

    children: [
    if(state is updateprofilemodelloading)
    LinearProgressIndicator(),
    SizedBox(height: 20,),
    defaulttext(
    controller: nameccontrolle,
    type: TextInputType.name,
    prefix: Icons.person,
    text: "Name",
    validate: ((value){
    if(value==null)
    return"name must not empity";
    }),
    ),
    SizedBox(height: 20,),
    defaulttext(
    controller: emaicontrolle,
    type: TextInputType.emailAddress,
    prefix: Icons.email,
    text: "Email Address",
    validate: ((value){
    if(value==null)
    return"email must not empity";
    }),
    ),
    SizedBox(height: 20,),
    defaulttext(
    controller: phonecontroller,
    type: TextInputType.phone,
    prefix: Icons.phone,
    text: "Phone",
    validate: ((value){
    if(value==null)
    return"phone must not empity";
    }),
    ),
    SizedBox(height: 20,),
    Container(
    color: Colors.deepOrange,
    width: double.infinity,
    child: TextButton(onPressed: (){
    shoplayoutcubit.get(context).updateprofiledata(
    email: emaicontrolle.text,
    phone: phonecontroller.text,
    name: nameccontrolle.text,
    );

    }, child: Text(
    "Update",
    style: TextStyle(
    color: Colors.white,

    ),
    )),
    ),
    SizedBox(height: 20,),

    Container(
    color: Colors.deepOrange,
    width: double.infinity,
    child: TextButton(onPressed: (){
    shared.clear(key: 'token');
    Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder: (context)=>loginshopscreen())
    , (route) => false);
    }, child: Text(
    "LOGOUT",
    style: TextStyle(
    color: Colors.white,

    ),
    )),
    ),

    ],
    ),
    );
      },
    );
  }
}
