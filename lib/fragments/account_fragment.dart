import 'package:flutter/material.dart';
import 'package:wallet_exe/data/dao/account_table.dart';
import 'package:wallet_exe/widgets/card_list_account.dart';

class AccountFragment extends StatefulWidget {
  AccountFragment({Key key}) : super(key: key);

  @override
  _AccountFragmentState createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {
  @override
  Widget build(BuildContext context) {
    Future<String> t = AccountTable().getTotalBalance();
    print(t);
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
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
              'Tổng tiền: 1.596.000 đ',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          SizedBox(height: 15,),

          CardListAccount(),
        ],
      ),
    );
  }
}
