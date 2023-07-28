
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Network/login/login.dart';
import 'package:shopapp/Network/remote/diohelper.dart';
import 'package:shopapp/componet/mmm.dart';
import 'package:shopapp/modules/shop_app/cubit/states.dart';
import 'package:shopapp/modules/shop_app/loginshopscreen/loginshop_screen.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/cubit-shoplayout.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/states.dart';

class settingsscreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var nameccontrolle=TextEditingController();
    var emaicontrolle=TextEditingController();
    var phonecontroller=TextEditingController();




    return BlocConsumer<shoplayoutcubit,shoplayoutstates>(
      listener: (context,state){
        if(state is updateprofilemodelsucess){
          toast(text: state.upmodel.message.toString(), choose: toastchoose.success);

        }



      },
      builder: (context,state){
if(shoplayoutcubit.get(context).modelprofile!=null) {
  nameccontrolle.text = shoplayoutcubit
      .get(context)
      .modelprofile!
      .data!
      .name!;
  emaicontrolle.text = shoplayoutcubit
      .get(context)
      .modelprofile!
      .data!
      .email!;
  phonecontroller.text = shoplayoutcubit
      .get(context)
      .modelprofile!
      .data!
      .phone!;
}




        // condition: shoplayoutcubit.get(context).model!=null&&shoplayoutcubit.get(context).modelcategory!=null,
        return ConditionalBuilder(
          condition: shoplayoutcubit.get(context).modelprofile!=null ,

          builder: (context)=> Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(

                children: [
                  if(state is updateprofilemodelloading)
                    LinearProgressIndicator(),
                  SizedBox(height: 20,),
                  defaulttext2(
                    controller: nameccontrolle,
                    type: TextInputType.name,
                    prefix: Icons.person,
                    text: "Name",
                    validate: ((value){
                      if(value==null)
                        return"name must not empity";
                    }),
                  ),
                  SizedBox(height: 30,),
                  defaulttext2(
                    controller: emaicontrolle,
                    type: TextInputType.emailAddress,
                    prefix: Icons.email,
                    text: "Email Address",
                    validate: ((value){
                      if(value==null)
                        return"email must not empity";
                    }),
                  ),
                  SizedBox(height: 30,),
                  defaulttext2(
                    controller: phonecontroller,
                    type: TextInputType.phone,
                    prefix: Icons.phone,
                    text: "Phone",
                    validate: ((value){
                      if(value==null)
                        return"phone must not empity";
                    }),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    decoration:BoxDecoration(
                      color: Colors.deepOrange,

                      borderRadius: BorderRadius.circular(10),
                    ),
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
                  SizedBox(height: 25,),

                  Container(
                    decoration:BoxDecoration(
                      color: Colors.deepOrange,

                      borderRadius: BorderRadius.circular(10),
                    ),
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

                    ),



                    ),
                  ),

                ],
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator(color: Colors.deepOrange,)),
        );
      },
    );
  }
}
