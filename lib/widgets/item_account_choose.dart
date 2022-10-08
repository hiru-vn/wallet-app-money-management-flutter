import 'package:flutter/material.dart';
import 'package:wallet_exe/data/model/Account.dart';
import 'package:wallet_exe/utils/text_input_formater.dart';

class ItemAccountChoose extends StatelessWidget {
  final Account _account;

  const ItemAccountChoose(this._account);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: ListTile(
          leading: Padding(
            padding: EdgeInsets.all(5),
            child: Image.asset(_account.img),
          ),
          title: Text(this._account.name, style: Theme.of(context).textTheme.subtitle),
          subtitle: Text(textToCurrency(this._account.balance.toString())),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        onTap: () {
          Navigator.pop(context, this._account);
        },
    ));
  }
}
