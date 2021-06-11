import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_exe/bloc/transaction_bloc.dart';
import 'package:wallet_exe/data/dao/transaction_table.dart';
import 'package:wallet_exe/data/model/Transaction.dart';
import 'package:wallet_exe/enums/duration_filter.dart';
import 'package:wallet_exe/pages/records_page.dart';
import 'package:wallet_exe/utils/text_input_formater.dart';

class Cardbalance extends StatefulWidget {
  Cardbalance({Key key}) : super(key: key);

  @override
  _CardbalanceState createState() {
    return _CardbalanceState();
  }
}

class _CardbalanceState extends State<Cardbalance> {
  List _option = DurationFilter.getAllType();
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentOption;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentOption = DurationFilter.THISMONTH.name;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String option in _option) {
      items.add(DropdownMenuItem(value: option, child: Text(option)));
    }
    return items;
  }

  void changedDropDownItem(String selectedOption) {
    setState(() {
      _currentOption = selectedOption;
    });
  }

  void _navToRecords() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecordsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _bloc = TransactionBloc();
    _bloc.initData();
    return StreamBuilder<List<Transaction>>(
        stream: _bloc.transactionListStream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              if (snapshot.data.length == 0)
                return SizedBox(
                  height: 15,
                );
              final values = TransactionTable().getTotal(snapshot.data,
                  DurationFilter.valueFromName(this._currentOption));
              final inCome = values[0];
              final outCome = values[1];
              var sum = inCome + outCome;
              if (sum == 0) sum = 1;
              var inComeHeight = inCome / sum * 120 + 5;
              var outComeHeight = outCome / sum * 120 + 5;

              return Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 40,
                        child: Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: IntrinsicHeight(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Tình hình thu chi',
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        height: outComeHeight,
                                        width: ScreenUtil.getInstance()
                                            .setWidth(80),
                                        color: Colors.red,
                                      ),
                                      Container(
                                        height: inComeHeight,
                                        width: ScreenUtil.getInstance()
                                            .setWidth(80),
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                      flex: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          DropdownButton(
                            value: _currentOption,
                            items: _dropDownMenuItems,
                            onChanged: changedDropDownItem,
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Colors.green,
                                          radius: 5.0,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('Thu',
                                            style: TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            textToCurrency(inCome.toString()) +
                                                ' đ',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Colors.red,
                                          radius: 5.0,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('Chi',
                                            style: TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            textToCurrency(outCome.toString()) +
                                                ' đ',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.red, fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Tích lũy',
                                        style: TextStyle(fontSize: 16)),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            textToCurrency((inCome - outCome)
                                                    .toString()) +
                                                ' đ',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: _navToRecords,
                                      child: Text(
                                        "Xem ghi chép",
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.navigate_next,
                                      color: Colors.blue,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );

            default:
              return Center(
                child: Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              );
          }
        });
  }
}
