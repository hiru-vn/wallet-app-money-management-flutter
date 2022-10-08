import 'package:flutter/material.dart';
import 'package:wallet_exe/data/model/Transaction.dart';
import 'package:wallet_exe/enums/transaction_type.dart';
import 'package:wallet_exe/widgets/item_transaction.dart';

class CardTransaction extends StatelessWidget {
  List<Transaction> _list = List<Transaction>();
  DateTime _date;
  int _totalDay = 0;
  CardTransaction(this._list, this._date);

  List<Widget> _createRenderItem() {
    List<Widget> listItem = List<Widget>();
    for (int i = 0; i < _list.length; i++) {
      listItem.add(ItemTransaction(_list[i]));
      if (_list[i].category.transactionType == TransactionType.INCOME) {
        _totalDay += _list[i].amount;
      }
      if (_list[i].category.transactionType == TransactionType.EXPENSE) {
        _totalDay -= _list[i].amount;
      }
    }

    listItem.add(Divider(thickness: 2.0, indent: 15, endIndent: 15,));
    listItem.add(_createTotalTile(_totalDay));

    return listItem;
  }

  String _getDate() {
    return this._date.day.toString() +
        "/" +
        this._date.month.toString() +
        "/" +
        this._date.year.toString();
  }

  bool checkEqualDate(DateTime date1, DateTime date2) {
    if (date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year) return true;
    return false;
  }

  String _getTitle() {
    final now = DateTime.now();
    if (checkEqualDate(_date, now)) return ("Hôm nay");
    if (checkEqualDate(_date, now.subtract(Duration(days: 1))))
      return ("Hôm qua");
    if (checkEqualDate(_date, now.subtract(Duration(days: 2))))
      return ("Hôm kia");
    if (_date.weekday == 7) return "Chủ Nhật";

    return "Thứ " + (_date.weekday + 1).toString();
  }

  Widget _createTotalTile(int total) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(),
        ),
        Expanded(
          flex: 5,
          child: ListTile(
            title: Text("Tổng:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            trailing: Text(_totalDay.abs().toString(),
                style: TextStyle(
                    color: _totalDay > 0 ? Colors.green : Colors.red,
                    fontSize: 18)),
          ),
        )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.blueGrey
              : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0,
            ),
          ],
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _getTitle(),
                style: Theme.of(context).textTheme.title,
              ),
              Text(
                _getDate(),
                style: Theme.of(context).textTheme.subtitle,
              ),
            ],
          ),
          children: _createRenderItem(),
        ));
  }
}
