import 'package:flutter/material.dart';
import 'package:wallet_exe/bloc/account_bloc.dart';
import 'package:wallet_exe/data/dao/account_table.dart';
import 'package:wallet_exe/event/account_event.dart';
import 'package:wallet_exe/utils/text_input_formater.dart';
import 'package:wallet_exe/widgets/card_list_account.dart';

class AccountFragment extends StatefulWidget {
  AccountFragment({Key key}) : super(key: key);

  @override
  _AccountFragmentState createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {
  final _accountBloc = AccountBloc();
  int _balance = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _accountBloc.event.add(GetAllBalanceEvent());
    _accountBloc.balance.listen((balance) {
      setState(() {
        _balance = balance;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .brightness == Brightness.dark ? Colors.blueGrey : Colors
                  .white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 15.0),
                  blurRadius: 15.0,
                ),
              ],
            ),
            child: Text(
              'Tổng: ' + textToCurrency(_balance.toString()) + 'đ',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline6,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          CardListAccount(),
        ],
      ),
    );
  }
}
