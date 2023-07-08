

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Network/login/login.dart';
import 'package:shopapp/Network/remote/diohelper.dart';
import 'package:shopapp/componet/mmm.dart';
import 'package:shopapp/model/model.dart';
import 'package:shopapp/modules/cubit-Register/cubit.dart';
import 'package:shopapp/modules/cubit-Register/states.dart';
import 'package:shopapp/modules/shop_app/cubit/cubit.dart';
import 'package:shopapp/modules/shop_app/cubit/states.dart';
import 'package:shopapp/modules/shop_app/register_screen/Register-screen.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/cubit-shoplayout.dart';
import 'package:shopapp/modules/shop_app/shop_layout/shop_layout.dart';

class Registerhopscreen extends StatelessWidget {

  @override
   var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
  var namecontroller=TextEditingController();
  var phonecontroller=TextEditingController();
  final formkey = GlobalKey<FormState>();




  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) =>shopregistercubit(),
      child: BlocConsumer<shopregistercubit,shopregisterstates>
        (
        listener: (context,state){
          if(state is shopregistersucessstates){
         if(state.model.statues==true){
           token=state.model!.data!.token!;
           shared.savedata(key: "token", value: state.model.data?.token).then((value) {
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(coext)=>shoplayout()), (route) => false,);
           });
  Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadiusDirectional.circular(10),
  border: Border()
    ),
  );


         }
         else{
           print(state.model.message);
           toast(text: state.model.message.toString(), choose: toastchoose.error);


         }
          }
        },
          builder: (context,state){
          return Scaffold(
            appBar: AppBar(),

            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: (
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Register",
                              style: Theme.of(context).textTheme.headline4?.copyWith(color:Colors.black,fontWeight: FontWeight.bold),


                            ),
                            Text(
                              "Register now to browse our hot offers",
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(color:Colors.grey),
                            ),
                            SizedBox(height: 30 ,),

                            defaulttext(
                                controller: namecontroller,
                                type: TextInputType.name,
                                prefix: Icons.person,
                                text: "User Name",
                                validate: (String value){
                                  if(value.isEmpty){
                                    print("please enter your name ");
                                  }

                                  else{
                                    return null;
                                  }
                                }

                            ),
                            SizedBox(height: 15,),
                            defaulttext(
                                controller: phonecontroller,
                                type: TextInputType.phone,
                                prefix: Icons.phone,
                                text: "Phone",
                                validate: (String value){
                                  if(value.isEmpty){
                                    print("please enter your phone");
                                  }

                                  else{
                                    return null;
                                  }
                                }

                            ),
                            SizedBox(height: 15,),
                            defaulttext(
                                controller: emailcontroller,
                                type: TextInputType.emailAddress,
                                prefix: Icons.email_outlined,
                                text: "Email Address",
                                validate: (String value){
                                  if(value!.isEmpty){
                                    print("please enter your email address");
                                  }

                                  else{
                                    return null;
                                  }
                                }

                            ),
                            SizedBox(height: 15,),

                            defaulttext(
                                controller: passwordcontroller,
                                onchanged: (value){
                                },
                                onsubmited: (String value){
                                  print(value);
                                  if(formkey.currentState!.validate()){
                                    shopcubit.get(context).userlogin(
                                        email:emailcontroller.text,
                                        password: passwordcontroller.text);
                                  }
                                  else{
                                    return null;
                                  }
                                },
                                type: TextInputType.visiblePassword,
                                prefix: Icons.visibility_outlined,

                                text: "Password",
                                sufficon: shopregistercubit.get(context).icon?Icons.visibility:Icons.visibility_off,
                                isbass: shopregistercubit.get(context).icon?false:true,
                                onpressed: (){
                                  shopregistercubit.get(context).changeicon();
                                },
                                validate: (String value){
                                  if(value.isEmpty){
                                    print("password is too short");
                                  }
                                  else{
                                    return null;
                                  }

                                }

                            ),
                            SizedBox(height: 30,),
                            ConditionalBuilder(
                              condition: state is! shopregisterloadingstates,
                              builder: (context)=>Container(
                                width: double.infinity,
                                color: Colors.deepOrange,

                                child: (
                                    MaterialButton(
                                      onPressed: (){
                                        if(formkey.currentState!.validate()){
                                          shopregistercubit.get(context).userlogin(
                                              email:emailcontroller.text,
                                              password: passwordcontroller.text,
                                            name: namecontroller.text,
                                            phone: phonecontroller.text,
                                          );
                                          print(shopregistercubit.get(context).registermodel?.statues);

                                          if(shopregistercubit.get(context).registermodel?.statues==true){
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder:(context)=>shoplayout(),
                                              ),
                                                  (route) => false,
                                            );
token=shopregistercubit.get(context).registermodel!.data!.token!;
                                          }else{

                                          }

                                        }
                                        else{
                                          return null;
                                        }
                                      },
                                      child: Text(
                                        "Register",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),



                                    )
                                ),
                              ),
                              fallback:(context)=> Center(child: CircularProgressIndicator()),
                            ),
                            SizedBox(height: 15,),




                          ],

                        )
                    ),
                  ),
                ),
              ),
            ),
          );
          },

      )
    );
  }
}
