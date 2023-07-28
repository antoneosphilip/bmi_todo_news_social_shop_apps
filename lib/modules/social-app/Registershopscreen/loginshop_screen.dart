

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Network/login/login.dart';
import 'package:shopapp/Network/remote/diohelper.dart';
import 'package:shopapp/componet/mmm.dart';
import 'package:shopapp/layout/social-layout/social-layout.dart';
import 'package:shopapp/modules/cubit-Register/cubit.dart';

import 'package:shopapp/modules/shop_app/cubit/cubit.dart';
import 'package:shopapp/modules/social-app/Registershopscreen/cubit-Register/cubit.dart';
import 'package:shopapp/modules/social-app/Registershopscreen/cubit-Register/states.dart';


class Registersocialscreen extends StatelessWidget {

  @override
   var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
  var namecontroller=TextEditingController();
  var phonecontroller=TextEditingController();
  final formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {

        return BlocProvider(
          create: (BuildContext context)=>socialappregistercubit(),
          child: BlocConsumer<socialappregistercubit,socialappregisterstates>
            (
              listener: (context,state){

                if(state is socialappcreateusersucessstates){
                  uId='';
                  shared.savedata(key: "uId", value: state.uId).then((value) {
                    uId=state.uId;
                    socialappregistercubit.get(context).settoken();
                    Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder:(context)=>sociallayoutscreen()), (route) => false);

                  });
                }
                if(state is socialappregistererrorstates){

                  toast(text: state.error.toString(), choose: toastchoose.error);
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
                                "Register now to communicate with friends",
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

                                  },
                                  type: TextInputType.visiblePassword,
                                  prefix: Icons.visibility_outlined,

                                  text: "Password",
                                  sufficon: socialappregistercubit.get(context).icon?Icons.visibility:Icons.visibility_off,
                                  isbass: socialappregistercubit.get(context).icon?false:true,
                                  onpressed: (){
                                    socialappregistercubit.get(context).changeicon();
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
                                condition: state is! socialappregisterloadingstates,
                                builder: (context)=>Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,


                                    borderRadius: BorderRadius.circular(10),
                                  ),


                                  child: (
                                      MaterialButton(
                                        onPressed: (){
                                          if(formkey.currentState!.validate()){
socialappregistercubit.get(context).userlogin(name: namecontroller.text, phone: phonecontroller.text, email: emailcontroller.text, password: passwordcontroller.text);


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
