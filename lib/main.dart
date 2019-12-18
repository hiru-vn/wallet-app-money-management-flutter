import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_exe/data/database_helper.dart';
import 'package:wallet_exe/pages/main_page.dart';
import './bloc/account_bloc.dart';

void main() async { 
  await DatabaseHelper.instance.init();
  runApp(MyApp());
}

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
      home: MultiProvider(
          providers: [
            Provider<AccountBloc>.value(value: AccountBloc(),),
          ],
          child: MainPage(),
        ),
    );
  }
}