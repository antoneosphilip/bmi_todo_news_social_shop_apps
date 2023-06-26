


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componet/mmm.dart';

import '../../../layout/social-layout/social-cubit/social-cubit.dart';
import '../../../layout/social-layout/social-cubit/social-states.dart';

class updateprofilescreen extends StatelessWidget {

  var namecontroller=TextEditingController();

  var biocontroller=TextEditingController();
  var phonercontroller=TextEditingController();


  @override
  Widget build(BuildContext context) {





    return BlocConsumer<sociallayoutcubit,shoplayoutstates>(
      listener: (context,state){
        if(state is shoplayoutugetuserloadingtates){
          toast(text: "update successfully", choose: toastchoose.success);
        }

      },
      builder: (context,state){

        namecontroller.text=sociallayoutcubit.get(context).model!.name!;
      biocontroller.text=sociallayoutcubit.get(context).model!.bio!;
        phonercontroller.text=sociallayoutcubit.get(context).model!.phone!;



        return  Scaffold(
          appBar: AppBar(
            titleSpacing: 5,
            title: Text("Edit profile"),

            actions: [

              TextButton(
                  onPressed: (){
sociallayoutcubit.get(context).updatesuerdata(bio: biocontroller.text,phone: phonercontroller.text,name: namecontroller.text);
              }, child: Text("Update")),

              SizedBox(width: 15,),

            ],
          ),
          body: SingleChildScrollView(
            child: Column(

              children: [
                if(state is shoplayoutuupateuserloadingstates)
                LinearProgressIndicator(),
                if(state is shoplayoutuupateuserloadingstates)

                  SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 240,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            children: [
                              Container(
                                height: 180,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight:Radius.circular(4),

                                    ),
                                    image: DecorationImage(
                                      image: sociallayoutcubit.get(context).imagecover==null?NetworkImage(
'${sociallayoutcubit.get(context).model?.cover}'
                                    ):FileImage(sociallayoutcubit.get(context).imagecover!)as ImageProvider ,
                                      fit: BoxFit.cover,
                                    )
                                ),
                              ),
                              CircleAvatar(
                                  child: IconButton(onPressed: (){

                                    sociallayoutcubit.get(context).openImagePickecoverr();
                                  }, icon: Icon(Icons.camera_alt_outlined,
size: 16,
                              )),
                                radius: 17,

                              ),
                            ],
                            alignment: AlignmentDirectional.topEnd,
                          ),
                          alignment: AlignmentDirectional.topCenter,

                        ),
                        Stack(

                          children: [
                            Container(
                              child: CircleAvatar(
                                radius: 64,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(

                                  backgroundImage:sociallayoutcubit.get(context).imageprofile==null?NetworkImage(
                                      '${sociallayoutcubit.get(context).model?.image}',
                                  ):FileImage(sociallayoutcubit.get(context).imageprofile!)as ImageProvider,
                                  radius: 60,

                                ),

                              ),
                            ),


                            CircleAvatar(
                              child: IconButton(onPressed: (){
                                sociallayoutcubit.get(context).openImagePicker();

                               }, icon: Icon(Icons.camera_alt_outlined,
                                size: 16,
                              )),
radius: 17,
                            ),
                          ],
                          alignment: AlignmentDirectional.bottomEnd,
                        ),

                      ],
                    ),
                  ),
                ),



                SizedBox(height: 20,),
                if(sociallayoutcubit.get(context).imageprofile!=null||sociallayoutcubit.get(context).imagecover!=null)
                  Row(
                    children: [
if(sociallayoutcubit.get(context).imageprofile!=null)
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              color: Colors.blue,
                              child: TextButton(onPressed: (){
                                sociallayoutcubit.get(context).updateuploadprofile(name: namecontroller.text,
                                    bio: biocontroller.text,
                                    phone: phonercontroller.text);
                              }, child: Text("UPLODE PROFILE",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),

                          ],

                        ),

                      ),

                      SizedBox(width: 5,),

                      if(sociallayoutcubit.get(context).imagecover!=null)
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                color: Colors.blue,
                                child: TextButton(onPressed: (){
                                  sociallayoutcubit.get(context).updateuploadcover(name: namecontroller.text,
                                      bio: biocontroller.text,
                                      phone: phonercontroller.text);
                                }, child: Text("UPLODE COVER",
                                  style: TextStyle(color: Colors.white),


                                )),
                              ),

                            ],
                          ),
                        ),



                    ],
                  ),

                SizedBox(height: 10,),
                defaulttext(
                    controller: namecontroller,
                    type: TextInputType.text,
                    prefix: Icons.person,
                    text: "Name",
                    validate: (String name){
                      if(name.isEmpty)
                      {
                        return "name must not be empity";
                      }

                    }),
                SizedBox(height: 10,),
                defaulttext(
                    controller: biocontroller,
                    type: TextInputType.text,
                    prefix: Icons.info,
                    text: "bio",
                    validate: (String name){
                      if(name.isEmpty)
                      {
                        return "bio must not be empity";

                      }

                    }),
                SizedBox(height: 10,),
                defaulttext(
                    controller: phonercontroller,
                    type: TextInputType.phone,
                    prefix: Icons.phone,
                    text: "phone",
                    validate: (String name){
                      if(name.isEmpty)
                      {
                        return "phone number must not be empity";

                      }

                    }),


              ],
            ),
          ),
        );
      },
    );
  }
}
