
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../model/social-model/social-model.dart';

class feeds2screen extends StatelessWidget {
  crateusermodel model;
  int index;
  feeds2screen(this.model,this.index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            child: Image(
              image:
            NetworkImage('${model.image}'),


            ),

          ),
          Text("${model.name}",
            style: TextStyle(
              fontSize: 30,
            ),

          ),

          SizedBox(height: 10,),
          Text("${model.email
          }",
            style: TextStyle(
              fontSize: 20,
            ),

          ),
          SizedBox(height: 10,),


          Text("${model.phone}",
            style: TextStyle(
              fontSize: 20,
            ),

          ),
          SizedBox(height: 10,),

          Text("joined since ${model.date
          }",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey
            ),

          ),
          SizedBox(height: 10,),

          if(model.bio!='Enter your bio')
            Text("${model.bio}",
              style: TextStyle(
                fontSize: 10,
              ),

            ),

        ],
      ),
    );
  }
}
