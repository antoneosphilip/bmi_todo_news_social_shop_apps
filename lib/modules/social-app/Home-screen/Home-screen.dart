
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopapp/componet/mmm.dart';
import 'package:shopapp/layout/social-layout/social-cubit/social-cubit.dart';
import 'package:shopapp/model/social-model/new-post-model/new-post-model.dart';
import 'package:shopapp/modules/social-app/new-post/new-post.dart';

import '../../../layout/social-layout/social-cubit/social-states.dart';

class Homescreen extends StatelessWidget {
  var commentcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool z=false;

    return Builder(
      builder: (BuildContext context) {
      return BlocConsumer<sociallayoutcubit,shoplayoutstates>(
        listener: (context,state){

        },
        builder: (context,state){

          return Scaffold(

            body: ConditionalBuilder(

              condition:sociallayoutcubit.get(context).posts.length>0 ,
              builder: (context)=>SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: EdgeInsets.all(8),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,

                        children: [
                          Image(
                            image: NetworkImage(
                                'https://img.freepik.com/free-photo/front-view-smiley-woman-listening-music-headphones_23-2148946273.jpg?t=st=1686924211~exp=1686924811~hmac=9b03995f68ae2b52e39cf809c24a52cf0c6b073e01edbecbcf21f8df4eaa1bc0'      ),
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,


                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "communicate with friends",
                              style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),

                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index)=>buildhomesocialitem(context,sociallayoutcubit.get(context).posts[index],index,index,state),
                        separatorBuilder: (context,index)=>SizedBox(height: 10,), itemCount: sociallayoutcubit.get(context).posts.length),

                  ],

                ),

              ),
              fallback: (context)=>Center(
                child: Text("no posts yet",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),

          );

        },
      );
      },
    );

  }
  Widget buildhomesocialitem(context,newpostmodel model,index,index2,state)=>
      Card(

    elevation: 5,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: EdgeInsets.symmetric(horizontal: 8),

    child: Padding(
      padding: const EdgeInsets.all(10.0),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(

                backgroundImage:NetworkImage(

                    '${model.image}',
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
                        '${model.name}',
                        style: TextStyle(height: 1.4),

                      ),
                      SizedBox(width: 5,),
                      Icon(Icons.check_circle,
                        color: Colors.blue,
                        size: 16,

                      ),

                    ],
                  ),
                  Text(
                    '${model.date}',
                    style: Theme.of(context).textTheme.caption?.copyWith(height: 1.4),

                  ),
                ],
              ),
              Spacer(),
              IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Container(
              height: 1,
              color: Colors.grey[300],
              width: double.infinity,

            ),

          ),
          Text(
  '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,

          ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 10,top: 5),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6),
          //           child: Container(
          //             height: 25,
          //             child: MaterialButton(onPressed: (){},
          //               padding: EdgeInsets.zero,
          //               minWidth: 1,
          //               child: Text(
          //                 "#software",
          //                 style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.blue),
          //               ),),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if(model.postimage!='')
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 15),
              child: Container(
              height: 300,

              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(image: NetworkImage(
                    '${model.postimage}',
                  ),
                    fit: BoxFit.cover,

                  )
              ),
          ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10  ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(

                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [

                           Icon(Iconsax.heart,
                            size: 16,
                            color: Colors.grey,
                          ),

                          SizedBox(width: 5,)
                          ,

                      ConditionalBuilder(
                        condition: sociallayoutcubit.get(context).likepostsnumber.length>0,
                       builder:(context)=>Text("${(sociallayoutcubit.get(context).likepostsnumber[index])}",
                            ),
                        fallback: (context)=>Text("0"),
                     ),
                        ],
                      ),
                    ),
                    onTap: (){

                    } ,
                  ),

                ),


  Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.mode_comment_rounded,
                            size: 16,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 5,),
//if(sociallayoutcubit.get(context).commentnumber2[index].like[index].length>0)
 //if(sociallayoutcubit.get(context).commenttitle.length>=0)
 ConditionalBuilder(
   condition:sociallayoutcubit.get(context).comment.length>0 ,
     builder:(context)=>Text("${sociallayoutcubit.get(context).comment[index]!} comment"),
   fallback:(context)=>Text("0") ,


 ) ,



                        ],
                      ),
                    ),
                    //Container(
                    //
                    //         child:      Padding(
                    //           padding: const EdgeInsets.all(10.0),
                    //
                    //         ))
                    onTap: (){
showBottomSheet(context: context, builder:(context)=>

    Container(
      height: 600,
              color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
  itemBuilder:(context,index)=> textform(),

        separatorBuilder:(context,index)=> SizedBox(height: 20,),
        itemCount: 1,
),
      ),
    ),

);
                    } ,
                  ),
                ),

              ],
            ),

          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              height: 1,
              color: Colors.grey[300],
              width: double.infinity,

            ),
          ),

          Row(
            children: [

              Expanded(
                child: InkWell(
                  onTap: (){

                    showBottomSheet(context: context, builder: (BuildContext context) =>Container(
                      height: 50,
                      child: defaulttext(controller:

                      commentcontroller,
                          type: TextInputType.text,
                          prefix: Icons.comment,
                          sufficon: (Iconsax.send1),

                          onpressed: (){
                        sociallayoutcubit.get(context).postcomment(sociallayoutcubit.get(context).commentposts[index], commentcontroller.text);

                        Navigator.pop(context);
                        commentcontroller.text='';
                          },
                          text: "Write comment",
                          validate: (){

                          }

                      ),

                    )



                    );
                  },
                  child: Row(
                    children: [
                      CircleAvatar(

                        backgroundImage:NetworkImage(

                          '${sociallayoutcubit.get(context).model?.image}',
                        ),

                        radius: 18,
                      ),
                      SizedBox(width: 15,),
                      Text(
                        "write a comment...",
                        style: Theme.of(context).textTheme.caption?.copyWith(height: 1.4),

                      ),
                    ],
                  ),
                ),
              ),

              InkWell(

                child: Padding(

                  padding: const EdgeInsets.symmetric(vertical: 5),

                  child: Row(

                    children: [



Icon(
  Iconsax.heart,
  color:Colors.red,

),

SizedBox(width: 5,),


                      Text("like"),
                    ],
                  ),
                ),
                onTap: (){
                  sociallayoutcubit.get(context).postlike(sociallayoutcubit.get(context).likeposts[index]);
                 // sociallayoutcubit.get(context).word(index);

                } ,
              ),


            ],
          ),
        ],

      ),
    ),
  );

  Widget textform()=>Container(
    decoration: BoxDecoration(
      color: Colors.red,
      border: Border.all(
        color: Colors.grey,
        width: 30
      ),
      borderRadius: BorderRadius.circular(20),
    ),
  );
}
