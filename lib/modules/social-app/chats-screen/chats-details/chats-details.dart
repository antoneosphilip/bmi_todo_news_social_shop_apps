

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopapp/Network/login/login.dart';
import 'package:shopapp/layout/social-layout/social-cubit/social-cubit.dart';
import 'package:shopapp/modules/social-app/chats-screen/chats-details/chat-model.dart';

import '../../../../layout/social-layout/social-cubit/social-states.dart';
import '../../../../model/social-model/social-model.dart';

class chatsdetailsscreen extends StatelessWidget {
 final crateusermodel model2;
 final int index;

 chatsdetailsscreen(this.model2,this.index);
var messagevontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        sociallayoutcubit.get(context).getmessage(reserveid: model2.uId);
        return BlocConsumer<sociallayoutcubit,shoplayoutstates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  children: [

                    CircleAvatar(
                      backgroundImage: NetworkImage(

                        '${model2.image}',
                      ),


                      radius: 20,


                    ),
                    SizedBox(width: 15,),
                    Text(
                      '${model2.name}',


                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: true,
                builder:(context)=>  Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context,index){
                            if(sociallayoutcubit.get(context).messagelist[index].senderid==sociallayoutcubit.get(context).model?.uId){
                              return  right(sociallayoutcubit.get(context).messagelist[index]);

                            }
                            else{
                              return  left(sociallayoutcubit.get(context).messagelist[index]);

                            }

                          },
                          separatorBuilder:(context,index)=> SizedBox(height: 15,),
                          itemCount: sociallayoutcubit.get(context).messagelist.length ?? 0,
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer  ,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),

                        ),
                        child: Row(
                          children: [

                            Expanded(
                              child: Container(

                                child: TextFormField(
                                  controller:messagevontroller,

                                  decoration: InputDecoration(

                                      border: InputBorder.none,
                                      hintText: "Enter your message"
                                  ),
                                ),
                              ),
                            ),
                            TextButton(onPressed: (){
                              // print(sociallayoutcubit.get(context).messagelist?[index].Text);
                              // print(sociallayoutcubit.get(context).users![index].image);
                              sociallayoutcubit.get(context).setmessage(date: DateTime.now().toString(), recieverid:model2.uId,

                                  text: messagevontroller.text

                              );
                             // sociallayoutcubit.get(context).messagesend(to:token2);
                              sociallayoutcubit.sendFcmMessage(

                                  "from ${sociallayoutcubit.get(context).model?.name}",
                                  "${messagevontroller.text}",
                                model2.tokenn,
                              );
                              messagevontroller.text='';
                              print("token is");
                              print(model2.tokenn);

                            }, child: Icon(Iconsax.send1,))
                          ],
                        ),
                      ),

                    ],

                  ),
                ),
                   
                fallback:(context)=>  Center(child: CircularProgressIndicator()) ,
              ),

            );
          },
        );

      },

    );
  }
  Widget left(chatmodel model)=>  Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 5,
        horizontal: 10,

      ),
      child: Text("${model.Text}"),
    ),
  );
  Widget right(chatmodel model)=>  Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 5,
        horizontal: 10,

      ),
      child: Text("${model.Text}"),
    ),
  );


}
