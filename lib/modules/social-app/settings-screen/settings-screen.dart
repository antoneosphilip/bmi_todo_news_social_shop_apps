
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/social-layout/social-cubit/social-cubit.dart';

import '../../../layout/social-layout/social-cubit/social-states.dart';
import '../../shop_app/update-profile/update-profile.dart';
import '../Registershopscreen/cubit-Register/cubit.dart';
import '../Registershopscreen/cubit-Register/states.dart';

class settingsscreen extends StatelessWidget {
  const settingsscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<sociallayoutcubit,shoplayoutstates>(
      listener:(context,state){} ,
     builder: (context,state){return Scaffold(
       body: Column(
         children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
               height: 240,
               child: Stack(
                 alignment: Alignment.bottomCenter,
                 children: [
                   Align(
                     child: Container(
                       height: 180,
                       width: double.infinity,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.only(
                             topLeft: Radius.circular(4),
                             topRight:Radius.circular(4),

                           ),
                           image: DecorationImage(image: NetworkImage(
                               '${sociallayoutcubit.get(context).model?.cover}'

                           ),
                             fit: BoxFit.cover,
                           )
                       ),
                     ),
                     alignment: AlignmentDirectional.topCenter,

                   ),
                   Container(
                     child: CircleAvatar(
                       radius: 64,
                       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                       child: CircleAvatar(

                         backgroundImage:NetworkImage(
'${sociallayoutcubit.get(context).model?.image}'
                         ),
                         radius: 60,

                       ),
                     ),
                   ),

                 ],
               ),
             ),
           ),
           Text(
             '${sociallayoutcubit.get(context).model?.name}'
             ,
             style: Theme.of(context).textTheme.bodyText1,

           ),
           Text(
             "${sociallayoutcubit.get(context).model?.bio}",
             style: Theme.of(context).textTheme.caption,

           ),
           SizedBox(height: 5,),
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 20),
             child: Row(
               children: [
                 Expanded(

                   child: InkWell(
                     child: Column(
                       children: [
                         Text(
                           "100",
                           style: Theme.of(context).textTheme.subtitle1,

                         ),
                         Text(
                           "post",
                           style: Theme.of(context).textTheme.caption,

                         ),

                       ],
                     ),
                     onTap: (){},
                   ),
                 ),
                 Expanded(

                   child: InkWell(
                     child: Column(
                       children: [
                         Text(
                           "10k",
                           style: Theme.of(context).textTheme.subtitle1,

                         ),
                         Text(
                           "Followers",
                           style: Theme.of(context).textTheme.caption,

                         ),

                       ],
                     ),
                     onTap: (){},
                   ),
                 ),
                 Expanded(

                   child: InkWell(
                     child: Column(
                       children: [
                         Text(
                           "100",
                           style: Theme.of(context).textTheme.subtitle1,

                         ),
                         Text(
                           "Following",
                           style: Theme.of(context).textTheme.caption,

                         ),

                       ],
                     ),
                     onTap: (){},
                   ),
                 ),
                 Expanded(

                   child: InkWell(
                     child: Column(
                       children: [
                         Text(
                           "1200",
                           style: Theme.of(context).textTheme.subtitle1,

                         ),
                         Text(
                           "Friends",
                           style: Theme.of(context).textTheme.caption,

                         ),

                       ],
                     ),
                     onTap: (){},
                   ),
                 ),

               ],
             ),
           ),
           Row(
             children: [
               Expanded(
                 child: OutlinedButton(onPressed: (){},
                     child:  Text(
                         "ADD PHOTO"
                     )),
               ),
               SizedBox(width: 10,),
               IconButton(onPressed: (){

                 Navigator.push(context, MaterialPageRoute(builder: (context)=>updateprofilescreen()));

               }, icon: Icon(Icons.edit,size: 16,),

               ),

             ],
           )



         ],
       ),
     );},
    );
  }
}
