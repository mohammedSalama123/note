import 'package:flutter/material.dart';

class MyThemeData{
  static const Color lightBackground=Colors.white;
  static const Color darkBackground=Colors.black;
  static const Color darkprimerSwatch=Colors.white;
  static const Color darkBackground2=Color(0xff141A2E);



  static final ThemeData lightThem= ThemeData(
      scaffoldBackgroundColor: lightBackground,
    iconTheme: const IconThemeData(color: Colors.black),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.red),
      backgroundColor: lightBackground,
      titleTextStyle: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold),
      actionsIconTheme: IconThemeData(color: Colors.red),
    ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.red,foregroundColor: Colors.white),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.black,),
      bodyText2: TextStyle(color: Colors.black,fontSize: 18,)
    ),



  );

  static final ThemeData darkThem= ThemeData(
      iconTheme: const IconThemeData(color: Colors.white),
    scaffoldBackgroundColor: darkBackground2,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: darkBackground2,
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.white,foregroundColor: Colors.black),
      textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.white,),
          bodyText2: TextStyle(color: Colors.white,fontSize: 18,),
      ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        color: Colors.white,
      ),

    )


  );
}