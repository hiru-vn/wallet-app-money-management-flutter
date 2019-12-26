import 'package:flutter/material.dart';
import 'package:wallet_exe/bloc/account_bloc.dart';
import 'package:wallet_exe/bloc/transaction_bloc.dart';
import 'package:wallet_exe/data/dao/account_table.dart';
import 'package:wallet_exe/data/model/Transaction.dart';
import 'package:wallet_exe/widgets/card_transaction.dart';

class TransactionFragment extends StatefulWidget {
  TransactionFragment({Key key}) : super(key: key);

  @override
  _TransactionFragmentState createState() => _TransactionFragmentState();
}

class _TransactionFragmentState extends State<TransactionFragment> {
  DateTime selectedDate = DateTime.now();
  String _currentOption;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    print(selectedDate);
  }

  @override
  void initState() {
    _currentOption = "Tất cả";
    super.initState();
  }

  List<DropdownMenuItem<String>> _getDropDownMenuItems(snapshotData) {
    var listItem = snapshotData as List<String>;
    List<DropdownMenuItem<String>> items = new List();
    for (String option in listItem) {
      items.add(DropdownMenuItem(value: option, child: Text(option)));
    }
    return items;
  }

  List<Widget> _createListCardTransaction(List<Transaction> list) {
    List<Widget> result = List<Widget>();
    List<Transaction> filter = list;

    if (_currentOption != "Tất cả")
      filter =
          list.where((item) => (item.account.name == _currentOption)).toList();
    
    // if user find day
    if (this.selectedDate.day != DateTime.now().day ||
        this.selectedDate.month != DateTime.now().month ||
        this.selectedDate.year != DateTime.now().year) {
      filter = filter
          .where((item) => (item.date.year == selectedDate.year &&
              item.date.month == selectedDate.month &&
              item.date.day == selectedDate.day))
          .toList();
      result.add(CardTransaction(filter, this.selectedDate));
      return result;
    }

    var tempFilter = filter;
    // the last 7 days
    DateTime flagDate = DateTime.now();
    for (int i = 0; i < 7; i++) {
      filter = tempFilter
        .where((item) => (item.date.year == flagDate.year &&
            item.date.month == flagDate.month &&
            item.date.day == flagDate.day))
        .toList();
      result.add(CardTransaction(filter, flagDate));
      result.add(SizedBox(height: 15));
      flagDate = flagDate.subtract(Duration(days: 1));
    }

    return result;
  }

  void changedDropDownItem(String selectedOption) {
    setState(() {
      _currentOption = selectedOption;
    });
  }

  @override
  Widget build(BuildContext context) {
    var blocAccount = AccountBloc();
    var blocTransaction = TransactionBloc();
    blocAccount.initData();
    blocTransaction.initData();

    return StreamBuilder<List<Transaction>>(
      stream: blocTransaction.transactionListStream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
            return Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Tài khoản:',
                              style: Theme.of(context).textTheme.subhead,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FutureBuilder<List<String>>(
                                future: AccountTable().getAllAccountName(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot2) {
                                  if (snapshot2.hasError) {
                                    print(snapshot2.error.toString());
                                    return Center(
                                        child: Text(snapshot2.error.toString()));
                                  } else if (snapshot2.hasData) {
                                    return DropdownButton<String>(
                                      value: _currentOption,
                                      items:
                                          _getDropDownMenuItems(snapshot2.data),
                                      onChanged: changedDropDownItem,
                                    );
                                  }
                                  return Container(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(),
                                  );
                                }),
                          ],
                        ),
                        RaisedButton(
                          onPressed: () => _selectDate(context),
                          child: Row(
                            children: <Widget>[
                              Text('Tìm ngày'),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.create, size: 20),
                            ],
                          ),
                          color: Theme.of(context).accentColor,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: _createListCardTransaction(snapshot.data),
                  )
                ],
              ),
            );

          case ConnectionState.waiting:
            return Center(
              child: Container(
                width: 100,
                height: 50,
                child: Text('Bạn chưa có giao dịch nào'),
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
      },
    );
  }
}
