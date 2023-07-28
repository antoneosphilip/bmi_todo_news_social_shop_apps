

import 'package:flutter/material.dart';
import 'package:shopapp/Network/remote/diohelper.dart';
import 'package:shopapp/modules/shop_app/loginshopscreen/loginshop_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class onboarding{
  final String image;
  final String title;
  final String body;
  onboarding({
    this.image='',
    this.title='',
     this.body='',

  });
}
class onboardingscreen extends StatefulWidget {
  @override
  State<onboardingscreen> createState() => _onboardingscreenState();
}

class _onboardingscreenState extends State<onboardingscreen> {

  List<onboarding> boarding=[
  onboarding(
    image: 'assets/images/USU-Online-Shopping-2.jpg',
    title: "Smart Shop",
    body: 'A smart store is a retail location that incorporates Internet of Things (IoT) technology to increase efficiency, convenience, and customer engagement. Some features of a smart store may include: ',
  ),
  onboarding(
    image: 'assets/images/maxresdefault.jpg',
    title: "Shop Easy",
    body: "Automated checkout systems that use sensors and cameras to track items and eliminate the need for checkout lines,Digital signage that displays personalized promotions and recommendations based on shopper behavior and preferences  ",
  ),
  onboarding(
    image: 'assets/images/shop.jpg',
    title: "Smart Shop Goals",
    body: 'Overall, the goal of a smart store is to create a seamless, personalized, and enjoyable shopping experience for customers while also streamlining operations and reducing costs for retailers.',
  )
];

var pagecontroller=PageController();

bool isboard=false;
bool saved=false;

  void push(){
shared.savedata(key: "isboard", value: true).then((value) {
  if(value==true){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder:(context)=>loginshopscreen(),
      ),
          (route) => false,
    );
  }
});

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
         TextButton(

             onPressed: (){
                 push();
         }, child: Text("SKIP",style: TextStyle(color: Colors.deepOrange),)

          )
        ],
      ),
      body:PageView.builder(
        onPageChanged: (index) {
          if(index==boarding.length-1){
            setState((){
           isboard=true;
}
            );
          }else{
            setState((){
              isboard=false;
            }
            );
            }

        },
        physics: BouncingScrollPhysics(),
        controller: pagecontroller,
          itemBuilder: (context, index) => buildonboarding(boarding[index]),
        itemCount: boarding.length,
      )

    );


  }

  Widget buildonboarding(onboarding model)=> Padding(

    padding: const EdgeInsets.all(30.0),
    child: Container(
      height: 900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage('${model.image}'),

          ),

          ),
          SizedBox(height: 30,),

          Text(
            '${model.title}',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 20,),

          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(height: 40,),
          Row(
            children: [
              SmoothPageIndicator(
                  controller:pagecontroller ,
                count: boarding.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: Colors.deepOrange,
                  dotColor: Colors.grey,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5,
                ),

              ),
              Spacer(),
              FloatingActionButton(
backgroundColor: Colors.deepOrange,
                onPressed: (){
                if(isboard){
 push();

                }
                else{
                  pagecontroller.nextPage(
                      duration: Duration(
                    milliseconds: 750,
                    ), curve: Curves.fastLinearToSlowEaseIn
                  );
                }

              },child: Icon(Icons.arrow_forward_ios,color: Colors.white,),),
              SizedBox(height: 20,),

            ],
          ),
        ],
      ),
    ),
  );
}
