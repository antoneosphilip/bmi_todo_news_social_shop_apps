



import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componet/mmm.dart';
import 'package:shopapp/modules/shop_app/cubit/states.dart';
import 'package:shopapp/modules/shop_app/model/category-model.dart';
import 'package:shopapp/modules/shop_app/model/favmodel.dart';
import 'package:shopapp/modules/shop_app/model/homemodel.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/cubit-shoplayout.dart';
import 'package:shopapp/modules/shop_app/shop_layout/cubit/states.dart';

class productscreen extends StatelessWidget {
  const productscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shoplayoutcubit,shoplayoutstates>(

        listener: (context,state){
          if(state is shopfavsuccess){
if(state.model.status==false){
  toast(text: state.model.message.toString(), choose: toastchoose.error);
}
          }
        },
      builder: (context,state){
        return ConditionalBuilder(
          condition: shoplayoutcubit.get(context).model!=null&&shoplayoutcubit.get(context).modelcategory!=null,
          builder:(context)=> productbuilder(shoplayoutcubit.get(context).model,context),
          fallback:(context)=> Center(child: CircularProgressIndicator(color: Colors.deepOrange,)),
        );
      },
    );
  }

}
Widget productbuilder(homemodel? model,context)=>SingleChildScrollView(
  physics: BouncingScrollPhysics(),
  child:  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CarouselSlider(
        items: [
          Image(
            image:  AssetImage('assets/images/ce0ef3991b548cbfcc36a0e9c6d34745.jpg'),
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Image(

            image: AssetImage('assets/images/1680055803aDUjo.36.png'),
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Image(
            image: AssetImage('assets/images/1680057283HBnq8.40.png'),
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Image(
            image:AssetImage('assets/images/1680055989g181K.37.png'),
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Image(
            image: AssetImage('assets/images/online-shopping-apps.jpg'),
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Image(
            image: AssetImage('assets/images/maxresdefault.jpg'),
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Image(
            image: AssetImage('assets/images/img_best_shopping_apps.jpg'),
            width: double.infinity,
            fit: BoxFit.fill,
          ),


        ],

        options: CarouselOptions(
          height: 250,
          initialPage: 0,
          enableInfiniteScroll: true,
          autoPlay: true,
          reverse: false,
          viewportFraction: 1,
          autoPlayAnimationDuration: Duration(seconds:1),
          autoPlayInterval: Duration(seconds: 2),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ),
      ),
      SizedBox(height: 10,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,

                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 100,

                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index)=>categories(shoplayoutcubit.get(context).modelcategory?.data?.data?[index]),
                    separatorBuilder: (context,index)=>SizedBox(width: 10,),
                    itemCount: shoplayoutcubit.get(context).modelcategory!.data!.data!.length,
                  ),
                ),

              ],
            ),
            SizedBox(height: 20,),

            Text("New Products",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800

              ),
            ),
            SizedBox(height: 10,),

          ],
        ),
      ),


      GridView.count(
        shrinkWrap: true,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,

        physics: NeverScrollableScrollPhysics(),
        childAspectRatio: 1/1.61,
        crossAxisCount: 2,
        children: List.generate(
          shoplayoutcubit.get(context).model!.data!.products!.length
          , (index) =>columnproduct(context,index,shoplayoutcubit.get(context).model!.data!.products![index]),

        ),
      )],

  ),

);
Widget columnproduct(context,index,productsobject?model)=>Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Stack(

      children: [
        Image(
          image: NetworkImage('${shoplayoutcubit.get(context).model?.data?.products![index].image}',
        ),
          width: double.infinity,
          height: 200,

        ),
        if(shoplayoutcubit.get(context).model?.data?.products?[index].discount !=0)

          Container(
          padding: EdgeInsets.symmetric(horizontal: 5,),
          color: Colors.red,
          child: Text("DISCOUNT",
            style: TextStyle(
              fontSize: 8,
              color: Colors.white,
            ),
          ),
        ),

      ],
alignment: AlignmentDirectional.bottomStart,
    ),
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(

              shoplayoutcubit.get(context).model!.data!.products![index].name.toString(),
            style: TextStyle(fontSize: 14,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,

          ),
          Row(
            children: [
              Text(
                  shoplayoutcubit.get(context).model!.data!.products![index].price.toString()+"\£",
                style: TextStyle(fontSize: 12,
                  color: Colors.deepOrange,
                ),
              ),
              SizedBox(width: 5,),
              if(shoplayoutcubit.get(context).model?.data?.products?[index].discount !=0)
              Text(
                shoplayoutcubit.get(context).model!.data!.products![index].oldprice.toString()+"\£",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Spacer(),
IconButton(

  padding: EdgeInsets.zero,
  onPressed: (){
    shoplayoutcubit.get(context).changefav(shoplayoutcubit.get(context).model!.data!.products![index].id!)
    ;},
  icon:CircleAvatar(
    radius: 15,
    backgroundColor:
    shoplayoutcubit.get(context).faveorite![model!.id]! ? Colors.deepOrange: Colors.grey,
      child: Icon(
 Icons.favorite_border_outlined,
        size: 14,
        color: Colors.white,
      )
  ),


),

            ],
          ),
        ],
      ),
    ),

  ],
);
Widget categories(datamodel? model)=> Stack(
  alignment: Alignment.bottomCenter,
  children: [
    Image(
      image: NetworkImage('${model?.image}'),
      height: 100,
      width: 100,
      fit: BoxFit.cover,
    ),
    Container(
      color: Colors.black.withOpacity(.8),
      width: 100,
      child: Text(

        "${model?.name}",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),

  ],
);


