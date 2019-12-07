import 'package:flutter/material.dart';
import 'package:wallet_exe/widgets/item_account.dart';

class CardListAccount extends StatefulWidget {
  CardListAccount({Key key}) : super(key: key);

  @override
  _CardListAccountState createState() => _CardListAccountState();
}

class _CardListAccountState extends State<CardListAccount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: ExpansionTile(
              title: Text("Đang sử dụng: (1.596.000 đ)",style: Theme.of(context).textTheme.subhead,),
              initiallyExpanded: true,
              children: <Widget>[
                ItemAccount('assets/bank.png', 'ATM', 1500000.toString()),
                ItemAccount('assets/bank.png', 'ATM', 1500000.toString()),
                ItemAccount('assets/bank.png', 'ATM', 1500000.toString()),
                ItemAccount('assets/bank.png', 'ATM', 1500000.toString()),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: ExpansionTile(
              title: Text("Tài khoản tiết kiệm: (1.596.000 đ)",style: Theme.of(context).textTheme.subhead,),
              initiallyExpanded: false,
              children: <Widget>[
                ItemAccount('assets/bank.png', 'ATM', 1500000.toString()),
                ItemAccount('assets/bank.png', 'ATM', 1500000.toString()),
                ItemAccount('assets/bank.png', 'ATM', 1500000.toString()),
                ItemAccount('assets/bank.png', 'ATM', 1500000.toString()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
