import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_exe/bloc/category_bloc.dart';
import 'package:wallet_exe/bloc/spend_limit_bloc.dart';
import 'package:wallet_exe/bloc/transaction_bloc.dart';
import 'package:wallet_exe/data/database_helper.dart';
import 'package:wallet_exe/pages/main_page.dart';
import 'package:wallet_exe/themes/theme.dart';
import 'package:wallet_exe/themes/theme_bloc.dart';
import './bloc/account_bloc.dart';

void main() async {
  await DatabaseHelper.instance.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var accountBloc = AccountBloc();
    var transactionBloc = TransactionBloc();
    var categoryBloc = CategoryBloc();
    var spendLimitBloc = SpendLimitBloc();
    var themeBloc = ThemeBloc();
    accountBloc.initData();
    transactionBloc.initData();
    categoryBloc.initData();
    spendLimitBloc.initData();

    return MultiProvider(
      providers: [
        Provider<AccountBloc>.value(
          value: accountBloc,
        ),
        Provider<TransactionBloc>.value(
          value: transactionBloc,
        ),
        Provider<CategoryBloc>.value(
          value: categoryBloc,
        ),
        Provider<SpendLimitBloc>.value(
          value: spendLimitBloc,
        ),
        Provider<ThemeBloc>.value(
          value: themeBloc,
        )
      ],
      child: StreamBuilder(
          initialData: myThemes[0],
          stream: themeBloc.outTheme,
          builder: (context, AsyncSnapshot<AppTheme> snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
            }
            return MaterialApp(
              title: 'Wallet exe',
              theme: snapshot.hasData
                  ? _buildThemeData(snapshot.data)
                  : ThemeData(),
              home: MainPage(),
            );
          }),
    );
  }

  _buildThemeData(AppTheme appTheme) {
    return ThemeData(
      brightness: appTheme.theme.brightness,
      primarySwatch: appTheme.theme.primarySwatch,
      accentColor: appTheme.theme.accentColor,
      fontFamily: 'Quicksand'
    );
  }
}
