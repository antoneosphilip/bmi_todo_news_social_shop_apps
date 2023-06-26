import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopapp/componet/mmm.dart';
import 'package:shopapp/layout/social-layout/social-cubit/social-cubit.dart';
import 'package:shopapp/layout/social-layout/social-cubit/social-states.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/cubit-shoplayout.dart';

class sociallayoutscreen extends StatelessWidget {
  const sociallayoutscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<sociallayoutcubit,shoplayoutstates>
      (
     listener: (context,state){},

    builder: (context,state){
       return Scaffold(
         appBar: AppBar(
           title:sociallayoutcubit.get(context).titles[sociallayoutcubit.get(context).currentindex] ,
           actions: [
             IconButton(onPressed: (){}, icon: Icon(Iconsax.notification)),

             IconButton(onPressed: (){}, icon: Icon(Iconsax.search_normal_1)),
           ],
         ),
         body: sociallayoutcubit.get(context).screens[sociallayoutcubit.get(context).currentindex],
         bottomNavigationBar: BottomNavigationBar(
             onTap: (index){
               sociallayoutcubit.get(context).changebottomnav(index,context);
             },
           currentIndex: sociallayoutcubit.get(context).currentindex,

           items: [
             BottomNavigationBarItem(
                 icon: Icon(Iconsax.home),
             label: "Home"
             ),
             BottomNavigationBarItem(icon: Icon(Icons.chat),
                 label: "Chats"
             ),
             BottomNavigationBarItem(icon: Icon(Iconsax.add),
                 label: "post"
             ),

             BottomNavigationBarItem(icon: Icon(Iconsax.user),
                 label: "Users"


             ),
             BottomNavigationBarItem(icon: Icon(Iconsax.setting),
                 label: "Settings"


             ),
           ],
         ),
       )
    ;
     }
    );
  }
}
