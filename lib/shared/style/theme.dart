import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:Colors.white,
        statusBarIconBrightness:Brightness.dark, 
      )
    ),
    backgroundColor: Colors.white,
    
    
    textTheme:const TextTheme(
        subtitle2: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.w600
      ),
    
      subtitle1: TextStyle(
        color: Colors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        height: 1.3,
      )
    ),
    
  );
}
