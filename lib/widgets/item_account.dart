import 'package:flutter/material.dart';
import 'package:wallet_exe/utils/text_input_formater.dart';

class ItemAccount extends StatelessWidget {
  final _imgUrl;
  final _name;
  final _balance;

  const ItemAccount(this._imgUrl, this._name, this._balance);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Padding(
          padding: EdgeInsets.all(5),
          child: Image.asset(this._imgUrl),
        ),
        title: Text(this._name, style: Theme.of(context).textTheme.subtitle),
        subtitle: Text(textToCurrency(this._balance)),
        trailing: IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        ),
      )
    );
  }
}