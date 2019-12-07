import 'package:flutter/material.dart';

class ItemTransaction extends StatelessWidget {
  final _imgUrl;
  final _name;
  final _balance;

  const ItemTransaction(this._imgUrl, this._name, this._balance);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: Image.asset(this._imgUrl),
        ),
        title: Text(this._name, style: TextStyle(fontSize: 18)),
        trailing: Text(_balance.toString(), style: TextStyle(color: _balance>=0? Colors.green: Colors.red, fontSize: 18))
      )
    );
  }
}