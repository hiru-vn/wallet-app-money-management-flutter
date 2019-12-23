import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_exe/bloc/category_bloc.dart';
import 'package:wallet_exe/bloc/spend_limit_bloc.dart';
import 'package:wallet_exe/bloc/transaction_bloc.dart';
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
    var accountBloc = AccountBloc();
    var transactionBloc = TransactionBloc();
    var categoryBloc = CategoryBloc();
    var spendLimitBloc = SpendLimitBloc();
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
        )
      ],
      child: MaterialApp(
        title: 'Wallet exe',
        theme: ThemeData(
          primaryColor: Colors.amber,
          accentColor: Colors.amber[200],
        ),
        home: MainPage(),
      ),
    );
  }
}
