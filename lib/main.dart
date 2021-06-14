import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wallet_exe/bloc/category_bloc.dart';
import 'package:wallet_exe/bloc/spend_limit_bloc.dart';
import 'package:wallet_exe/bloc/transaction_bloc.dart';
import 'package:wallet_exe/bloc/user_account_bloc.dart';
import 'package:wallet_exe/data/database_helper.dart';
import 'package:wallet_exe/fragments/login_fragment.dart';
import 'package:wallet_exe/pages/main_page.dart';
import 'package:wallet_exe/themes/theme.dart';
import 'package:wallet_exe/themes/theme_bloc.dart';
import './bloc/account_bloc.dart';
import 'fragments/register_fragment.dart';
import 'fragments/splash_fragment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    var userBloc = UserAccountBloc();
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
        ),
        Provider<UserAccountBloc>.value(
          value: userBloc,
        ),
      ],
      child: StreamBuilder(
          initialData: myThemes[0],
          stream: themeBloc.outTheme,
          builder: (context, AsyncSnapshot<AppTheme> snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
            }
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Wallet exe',
              initialRoute: '/splash',
              routes: {
                '/splash': (context) => SplashFragment(),
                '/register': (context) => RegisterFragment(),
                '/home': (context) => MainPage(),
                '/login': (context) => LoginFragment(),
              },
              theme: snapshot.hasData
                  ? _buildThemeData(snapshot.data)
                  : ThemeData(),
            );
          }),
    );
  }

  _buildThemeData(AppTheme appTheme) {
    return ThemeData(
      brightness: appTheme.theme.brightness,
      primarySwatch: appTheme.theme.primarySwatch,
      accentColor: appTheme.theme.accentColor,
      fontFamily: 'Quicksand',
    );
  }
}
