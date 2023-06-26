
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componet/mmm.dart';
import 'package:shopapp/layout/social-layout/social-cubit/social-cubit.dart';

import '../../../layout/social-layout/social-cubit/social-states.dart';

class newpostscreen extends StatelessWidget {

var textcontroller=TextEditingController();
DateTime now = new DateTime.now();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<sociallayoutcubit,shoplayoutstates>(
      listener: (context,state){
        if(state is shoplayoutuppostsuccesstates){
          toast(text: "post uploaded successfully", choose: toastchoose.success);
        } if(state is shoplayoutuploadposterroestates)
        {
          toast(text: state.error, choose: toastchoose.error);
        }

      },
      builder: (context,state){

        return Scaffold(

          appBar:  AppBar(
            titleSpacing: 5,
            title: Text("Create Post"),

            actions: [

              Container(

                child: TextButton(

                    onPressed: (){
                      if(sociallayoutcubit.get(context).imagepost==null){
sociallayoutcubit.get(context).createusuerpost(date:now.toString() , text: textcontroller.text);
                      }
                      else{
                        sociallayoutcubit.get(context).uploadpost(date:now.toString() , text: textcontroller.text);


                      }
                    }, child: Text("POST",
                  style: TextStyle(fontSize: 15),

                )),
              ),

              SizedBox(width: 15,),

            ],
          ),
          body: Column(

            children: [
              if(state is shoplayoutucreatepostloadingstates)
              LinearProgressIndicator(),
              if(state is shoplayoutucreatepostloadingstates)

                SizedBox(height: 10,),
          


               Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      CircleAvatar(

                        backgroundImage:NetworkImage(

                          '${sociallayoutcubit.get(context).model?.image}',
                        ),

                        radius: 25,
                      ),
                      SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${sociallayoutcubit.get(context).model?.name}",
                                style: TextStyle(height: 1.4),

                              ),
                              SizedBox(width: 5,),

                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                ),
              

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "What is on your mind ${sociallayoutcubit.get(context).model?.name} ",
                      border: InputBorder.none,


                    ),
controller:textcontroller ,
                  ),
                ),
              ),
              if(sociallayoutcubit.get(context).imagepost!=null)
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 900,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image: FileImage(sociallayoutcubit.get(context).imagepost!)as ImageProvider ,
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                    CircleAvatar(
                      child: IconButton(
                          onPressed: (){
                        sociallayoutcubit.get(context).closephoto();
                      }, icon: Icon(Icons.close,
                        size: 17,
                      )),
                      radius: 20,

                    ),
                  ],
                  alignment: AlignmentDirectional.topEnd,
                ),
              ),
SizedBox(height: 10,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [


                     Expanded(
                       child: TextButton(

                          onPressed: (){
                            sociallayoutcubit.get(context).openImagePickeepost();
                          }, child:Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera),
                          SizedBox(width: 5,),
                          Text("Add Photo"),
                        ],
                    )),
                     ),



                  Expanded(
                    child: TextButton(

                        onPressed: (){}, child:Text("# tags")
                    ),
                  ),



            ],
          ),
        ]));
      },
    );
  }
}
