import 'package:flutter/material.dart';

class MyTheme {
  Brightness brightness;    
  MaterialColor primarySwatch;  
  Color accentColor;

  MyTheme(
      {this.brightness,      
      this.primarySwatch,   
      this.accentColor,   
      });
}

class AppTheme {
  String name;
  MyTheme theme;
  AppTheme(this.name, this.theme);
}

List<AppTheme> myThemes = [
  AppTheme(
      'Amber',
      MyTheme(
      brightness: Brightness.light,      
      primarySwatch: Colors.amber,  
      accentColor: Colors.amber[200],    
      )),
  AppTheme(
      'Blue',
      MyTheme(
      brightness: Brightness.light,      
      primarySwatch: Colors.blue,  
      accentColor: Colors.blue[200],    
      )),
  AppTheme(
    'Teal',
    MyTheme(
      brightness: Brightness.light,      
      primarySwatch: Colors.teal,  
      accentColor: Colors.teal[200],    
    ),
  ),
  AppTheme(
    'Orange',
    MyTheme(
      brightness: Brightness.light,      
      primarySwatch: Colors.orange, 
      accentColor: Colors.orange[200],     
    ),
  ),
  AppTheme(
    'Dark',
    MyTheme(
      brightness: Brightness.dark,      
      primarySwatch: Colors.blueGrey,  
      accentColor: Colors.blueGrey[200],    
    ),
  ),
];