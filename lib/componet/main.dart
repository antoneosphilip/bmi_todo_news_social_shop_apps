
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Network/remote/diohelper.dart';
import 'package:shopapp/cubit/states.dart';
import 'package:shopapp/layout/newsapp/cubit.dart';
import 'package:shopapp/layout/newsapp/newsapp_layout.dart';

import '../cubit/cubit.dart';

void main()async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Diohelper.init();
    await shared.init();
    bool? isDark=await shared.getdata(key:'light');
    runApp(MyApp(isDark!));
  }, (error, stack) {print(error);
  }
  );


}

class MyApp extends StatelessWidget
{
 final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {

    return  MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=>newcubit()..getdata()),
        BlocProvider(create: (context)=>Appcubit()..changecolormode(dark: isDark)),
      ],
      child: BlocConsumer<Appcubit,Appstates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),

              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,

              ),
            ),
            darkTheme: ThemeData(

                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.black,
                appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.black,
                  ),
                  backgroundColor: Colors.black,
                  elevation: 20,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),


                ),
textTheme: TextTheme(
  bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
  ),
),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(

                  backgroundColor: Colors.black,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
unselectedItemColor: Colors.grey,
elevation: 20,

                ),

            ),
themeMode: Appcubit.get(context).light? ThemeMode.dark : ThemeMode.light,
            home: newsapplayout(),
          );
        },
      ),
    );
  }
}
