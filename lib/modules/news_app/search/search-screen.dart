
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componet/mmm.dart';
import 'package:shopapp/layout/newsapp/cubit.dart';
import 'package:shopapp/layout/newsapp/states.dart';


class search extends StatelessWidget {
  const search({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    var searchcontroller=TextEditingController();
var list=newcubit.get(context).search;
    return BlocConsumer<newcubit,newsstates>(
      listener: (context,builder){},
      builder: (context,builder){
        return Scaffold(
            appBar: AppBar(),
            body : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
style: TextStyle(color: Colors.grey),
                    controller: searchcontroller,
                    keyboardType: TextInputType.text,
                    onChanged: (value){
newcubit.get(context).getdsearch(value);
                    },
                    validator: (value){
                      if(value!.isEmpty){

                        return "search cann't be empty";
                      }

                      return null;

                    },
                    decoration: InputDecoration(

                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.deepOrange),
                      labelText: "Search",
                      prefixIcon: Icon(
                        Icons.search,
color: Colors.deepOrange,
                      ),


                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.deepOrange,
                          width: 2.0,
                        ),
                      ),
                    ),

                  ),
                ),
             Expanded(
               child: ListView.separated(
                 itemBuilder:(context,index)=> builddio(
                newcubit.get(context).search[index],context,
               ), separatorBuilder: (context,item)=>seprator(),
                    itemCount:  newcubit.get(context).search.length,
               ),
             ),
              ],
            )


        );
      },
    );
  }
}
