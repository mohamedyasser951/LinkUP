import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    appBarTheme: const AppBarTheme(
      
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:Colors.black,
        statusBarIconBrightness:Brightness.dark, 
      )
    ),
  );
}
