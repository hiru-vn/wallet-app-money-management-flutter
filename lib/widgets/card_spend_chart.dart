import 'package:flutter/material.dart';
import 'package:wallet_exe/widgets/item_spend_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CardSpendChart extends StatefulWidget {
  CardSpendChart({Key key}) : super(key: key);

  @override
  _CardSpendChartState createState() => _CardSpendChartState();
}

class _CardSpendChartState extends State<CardSpendChart> {
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
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Chi tiêu năm nay',
                      style: Theme.of(context).textTheme.title),
                  RaisedButton(
                    onPressed: () => _selectDate(context),
                    child: Row(
                      children: <Widget>[
                        Text('Chọn năm'),
                        SizedBox(width: 5,),
                        Icon(Icons.create,size: 20),
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
                child: SpendChart(_createSampleData()),
              )
            ]));
  }

  static List<charts.Series<MoneySpend, String>> _createSampleData() {
    final data = [
      MoneySpend(1, 5),
      MoneySpend(2, 25),
      MoneySpend(3, 100),
      MoneySpend(4, 75),
      MoneySpend(5, 75),
      MoneySpend(6, 75),
      MoneySpend(7, 75),
      MoneySpend(8, 75),
      MoneySpend(9, 75),
      MoneySpend(10, 75),
      MoneySpend(11, 75),
      MoneySpend(12, 175),
    ];

    return [
      new charts.Series<MoneySpend, String>(
        id: 'MoneySpend',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (MoneySpend spend, _) => spend.month.toString(),
        measureFn: (MoneySpend spend, _) => spend.money,
        data: data,
      )
    ];
  }
}
