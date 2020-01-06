import 'package:flutter/material.dart';
import 'package:wallet_exe/bloc/transaction_bloc.dart';
import 'package:wallet_exe/data/model/Transaction.dart';
import 'package:wallet_exe/enums/transaction_type.dart';
import 'package:wallet_exe/utils/text_input_formater.dart';
import 'package:wallet_exe/widgets/item_spend_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CardEarnChart extends StatefulWidget {
  final showDetail;

  CardEarnChart({this.showDetail = false});

  @override
  _CardEarnChartState createState() => _CardEarnChartState();
}

class _CardEarnChartState extends State<CardEarnChart> {
  DateTime selectedDate = DateTime.now();

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
  }

  @override
  Widget build(BuildContext context) {
    var _bloc = TransactionBloc();
    _bloc.initData();

    Widget _detailContent(int totalYear) {
      return Padding(
        padding: EdgeInsets.only(right: 20, left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Trung bình tháng:',
                  style: Theme.of(context).textTheme.body2,
                ),
                Text(textToCurrency(
                        (totalYear / DateTime.now().month).round().toString()) +
                    ' đ'),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Tổng thu nhập:',
                  style: Theme.of(context).textTheme.body2,
                ),
                Text(textToCurrency(totalYear.toString()) + ' đ'),
              ],
            ),
          ],
        ),
      );
    }

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
        child: StreamBuilder(
          stream: _bloc.transactionListStream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Thu nhập năm nay',
                              style: Theme.of(context).textTheme.title),
                          RaisedButton(
                            onPressed: () => _selectDate(context),
                            child: Row(
                              children: <Widget>[
                                Text('Chọn năm'),
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
                      SizedBox(
                        height: 10,
                      ),
                      Text('(Đơn vị: Nghìn)'),
                      Container(
                        height: 200,
                        width: double.infinity,
                        child: SpendChart(_getData(snapshot.data)),
                      ),
                      widget.showDetail
                          ? _detailContent(_getTotal(snapshot.data))
                          : SizedBox(
                              height: 10,
                            )
                    ]);
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
        ));
  }

  int _getTotal(List<Transaction> list) {
    var now = DateTime.now();
    int total = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i].date.year == now.year &&
          list[i].category.transactionType == TransactionType.INCOME) {
        total += list[i].amount;
      }
    }
    return total;
  }

  List<charts.Series<MoneySpend, String>> _getData(List<Transaction> list) {
    List<int> totalByMonth = List<int>();
    int totalMonth = 0;
    int flagMonth = 1;
    list.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    list = list
        .where((item) =>
            (item.category.transactionType == TransactionType.INCOME &&
                item.date.year == selectedDate.year))
        .toList();
    for (int i = 0; i < list.length; i++) {
      while (flagMonth < list[i].date.month) {
        totalByMonth.add((totalMonth / 1000).round());
        totalMonth = 0;
        flagMonth++;
      }
      if (flagMonth == list[i].date.month) {
        totalMonth += list[i].amount;
      }
      if (flagMonth > list[i].date.month) {
        totalByMonth.add((totalMonth / 1000).round());
      }
      if (i > 0) {
        if (i == list.length - 1) {
          totalByMonth.add((totalMonth / 1000).round());
        }
      }
    }

    while (flagMonth < 12) {
      totalByMonth.add(0);
      flagMonth++;
    }

    var data = List.generate(totalByMonth.length, (index) {
      return MoneySpend(index + 1, totalByMonth[index]);
    });

    return [
      new charts.Series<MoneySpend, String>(
        id: 'MoneySpend',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (MoneySpend spend, _) => spend.month.toString(),
        measureFn: (MoneySpend spend, _) => spend.money,
        data: data,
      )
    ];
  }
}
