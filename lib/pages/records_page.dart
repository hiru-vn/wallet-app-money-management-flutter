import 'package:flutter/material.dart';
import 'package:wallet_exe/bloc/transaction_bloc.dart';
import 'package:wallet_exe/data/model/Transaction.dart';
import 'package:wallet_exe/enums/transaction_type.dart';
import 'package:wallet_exe/utils/text_input_formater.dart';

class RecordsPage extends StatelessWidget {
  const RecordsPage({Key key}) : super(key: key);

  _createList(List<Transaction> items) {
    //sort by date
    items.sort((a, b) {
      return b.date.compareTo(a.date);
    });
    List<Widget> list = List<Widget>();
    for (int i = 0; i < items.length; i++) {
      list.add(ListTile(
        leading: Icon(items[i].category.icon),
        title: Text(items[i].category.name),
        subtitle: Text(items[i].date.day.toString() +
            '/' +
            items[i].date.month.toString()),
        trailing: Text(
          textToCurrency(items[i].amount.toString()),
          style: TextStyle(
            color: items[i].category.transactionType == TransactionType.EXPENSE
                ? Colors.red
                : Colors.green,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
      // if (items[i].description.trim() != "") {
      //   list.add(Divider());
      //   list.add(Text(items[i].description));
      // }
      if (i != items.length - 1) {
        list.add(Divider());
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    var bloc = TransactionBloc();
    bloc.initData();

    return Scaffold(
        appBar: AppBar(
          title: Text('Ghi chép gần đây'),
        ),
        body: StreamBuilder<List<Transaction>>(
            stream: bloc.transactionListStream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                  return SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: _createList(snapshot.data),
                          ),
                        ],
                      ),
                    ),
                  );
                case ConnectionState.waiting:
                  return Center(
                    child: Container(
                      width: 100,
                      height: 50,
                      child: Text('Empty list'),
                    ),
                  );
                case ConnectionState.none:
                default:
                  return Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  );
              }
            }));
  }
}
