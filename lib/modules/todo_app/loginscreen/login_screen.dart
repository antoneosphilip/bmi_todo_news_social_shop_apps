import 'package:flutter/material.dart';
class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  @override
  Widget build(BuildContext context) {
    var emailcontroller=TextEditingController();
    var passcontroller=TextEditingController();
    final formkey= GlobalKey<FormState>();
    bool ispass=false;

    return Scaffold(
      appBar: AppBar(),
      body:
      Center(

        child: SingleChildScrollView(

          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 40,
                    ),

                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              SizedBox(
                  height: 10,
                ),

                const SizedBox(
                  height: 10,
                ),

                Container(
                  color: Colors.blue,
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: (){
                      if(formkey.currentState!.validate()){
                        print("ok");
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),


                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text("don\'t have an account"),
                    TextButton(

                        onPressed: (){

                        },
                        child:Text("register now")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ) ;


  }
}





