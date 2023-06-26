
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Network/remote/diohelper.dart';
import 'package:shopapp/layout/social-layout/social-layout.dart';
import 'package:shopapp/model/model.dart';
import 'package:shopapp/modules/shop_app/Registershopscreen/loginshop_screen.dart';
import 'package:shopapp/modules/shop_app/shop_layout/shop_layout.dart';
import 'package:shopapp/modules/social-app/Registershopscreen/loginshop_screen.dart';

import 'package:shopapp/modules/social-app/social-logins-creen/cubit/cubit.dart';
import 'package:shopapp/modules/social-app/social-logins-creen/cubit/states.dart';


import '../../../Network/login/login.dart';
import '../../../componet/mmm.dart';

class socialapploginscreen extends StatelessWidget {
  const socialapploginscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailcontroller=TextEditingController();
    var passwordcontroller=TextEditingController();
    final formkey = GlobalKey<FormState>();
    return  BlocProvider(
        create: (BuildContext context) =>socialappcubit(),
        child: BlocConsumer<socialappcubit,socialappstates>(
         listener: (context,state){

           if(state is socialapperrorstates){
         toast(text: state.error, choose: toastchoose.error);


           }
           if(state is socialappsucessstates){
uId='';
             shared.savedata(key: "uId", value: state.uId).then((value) {
               uId=state.uId;
               Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>sociallayoutscreen()), (route) => false);
               //socialappcubit.get(context).getuserdata();


             });

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
                              "LOGIN",
                              style: Theme.of(context).textTheme.headline4?.copyWith(color:Colors.black,fontWeight: FontWeight.bold),

                            ),
                            Text(
                              "login now to communicate with friends",
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(color:Colors.grey),
                            ),
                            SizedBox(height: 30,),
                            defaulttext(
                                controller: emailcontroller,
                                type: TextInputType.emailAddress,
                                prefix: Icons.email_outlined,
                                text: "Email Address",
                                validate: (String value){
                                  if(value.isEmpty){
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
                                    socialappcubit.get(context).userlogin(
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
                                sufficon: socialappcubit.get(context).icon?Icons.visibility:Icons.visibility_off,
                                isbass: socialappcubit.get(context).icon?false:true,
                                onpressed: (){
                                  socialappcubit.get(context).changeicon();
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
                              condition: state is! socialapploadingstates,
                              builder: (context)=>Container(
                                width: double.infinity,
                                color: Colors.blue,

                                child: (
                                    MaterialButton(
                                      onPressed: (){
                                        if(formkey.currentState!.validate()){
                                          socialappcubit.get(context).userlogin(
                                              email:emailcontroller.text,
                                              password: passwordcontroller.text
                                          );
                                        }
                                        else{
                                          return null;
                                        }
                                      },
                                      child: Text(
                                        "Login",
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

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("don\'t have an account?"),
                                TextButton(
                                  style: ButtonStyle(
foregroundColor: MaterialStatePropertyAll(Colors.blue),
                                  ),
                                    onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Registersocialscreen()),


                                  );
                                }, child: Text("register".toUpperCase()

                                )

                                ),


                              ],
                            ),


                          ],

                        )
                    ),
                  ),
                ),
              ),
            ),
          );
            }


        )
    );

  }
}
