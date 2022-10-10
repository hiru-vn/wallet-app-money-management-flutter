import 'package:flutter/material.dart';
import 'package:wallet_exe/data/model/Transaction.dart';
import 'package:wallet_exe/enums/transaction_type.dart';
import 'package:wallet_exe/pages/update_transaction_page.dart';

class ItemTransaction extends StatelessWidget {
  final Transaction _transaction;

  const ItemTransaction(this._transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UpdateTransactionPage(_transaction)),
        );
      },
      leading: Padding(
        padding: EdgeInsets.all(10),
        child: Icon(_transaction.category.icon),
      ),
      title:
          Text(this._transaction.category.name, style: TextStyle(fontSize: 18)),
      trailing: Text(this._transaction.amount.toString(),
          style: TextStyle(
              color: this._transaction.category.transactionType ==
                      TransactionType.INCOME
                  ? Colors.green
                  : Colors.red,
              fontSize: 18)),
    ));
  }
}
