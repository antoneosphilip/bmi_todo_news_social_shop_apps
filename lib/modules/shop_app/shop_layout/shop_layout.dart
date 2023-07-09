
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Network/remote/diohelper.dart';
import 'package:shopapp/modules/cart-screen/cart-screen.dart';
import 'package:shopapp/modules/shop_app/loginshopscreen/loginshop_screen.dart';
import 'package:shopapp/modules/shop_app/search-scrren/search.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/cubit-shoplayout.dart';

import 'cubit/cart.dart';
import 'cubit/states.dart';

class shoplayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cubit=shoplayoutcubit.get(context);
    return BlocConsumer<shoplayoutcubit,shoplayoutstates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text("sala"),
            actions: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>searchscreen()));
              }, icon: Icon(Icons.search)),
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>cartscreen(0)));
              }, icon:
              Stack(
                children: [
                  Icon(Icons.shopping_cart),
                  if(shoplayoutcubit.get(context).k==true)
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.red,
                  ),
                ],
              )),
            ],
          ),
          body: cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.deepOrange
              ,
              onTap: (index){
                cubit.changeborromnav(index);
              },
              currentIndex: cubit.currentindex,
              items:[

                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                  backgroundColor: Colors.deepOrange,


                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: "Categories",
                  backgroundColor: Colors.deepOrange,

                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: "Favorites",

                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Settings",

                )
              ]
          ),
        );

      },
    );

  }
}
