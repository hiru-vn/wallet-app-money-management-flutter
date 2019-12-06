import 'package:flutter/material.dart';
import 'package:wallet_exe/pages/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet exe',
      theme: ThemeData(
        primaryColor: Colors.amber,
        accentColor: Colors.amber[200],
      ),
      home: MainPage(),
    );
  }
}