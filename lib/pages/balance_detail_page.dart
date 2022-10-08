import 'package:flutter/material.dart';
import 'package:wallet_exe/data/dao/account_table.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:wallet_exe/data/model/Account.dart';
import 'package:wallet_exe/widgets/item_balance_chart_circle.dart';

class BalanceDetailPage extends StatelessWidget {
  const BalanceDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Số dư tài khoản'),
      ),
      body: Container(
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
        child: FutureBuilder(
          future: AccountTable().getAllAccount(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              return Column(
                children: <Widget>[
<<<<<<< HEAD
<<<<<<< HEAD
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Các tài khoản',
                    style: Theme.of(context).textTheme.TitleMedium,
                  ),
=======
                  SizedBox(height: 15,),
                  Text('Các tài khoản',
                      style: Theme.of(context).textTheme.title),
>>>>>>> parent of 4e15e8e (update new version)
=======
                  SizedBox(height: 15,),
                  Text('Các tài khoản',
                      style: Theme.of(context).textTheme.title),
>>>>>>> parent of 4e15e8e (update new version)
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 320,
                    width: double.infinity,
                    child: BalanceChartCircle(_createData(snapshot.data)),
                  ),
                  Text('Đơn vị: nghìn'),
                ],
              );
            }
            return Container(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  static List<charts.Series<BalanceDetail, String>> _createData(
      List<Account> list) {
    final List<Color> colors = [
      Colors.red,
      Colors.pinkAccent,
      Colors.blueAccent,
      Colors.green,
      Colors.purpleAccent,
      Colors.amberAccent,
      Colors.black54,
    ];

    List<BalanceDetail> data = [];
    BalanceDetail last = BalanceDetail("khác", 0);
    for (int i = 0; i < list.length; i++) {
      if (data.length < 6) {
        BalanceDetail item = BalanceDetail(list[i].name, list[i].balance);
        data.add(item);
        data[i].color = colors[i];
      } else if (data.length == 6) {
        last.balance += list[i].balance;
        if (i == list.length - 1) {
          data.add(last);
        }
      }
    }

    return [
      charts.Series<BalanceDetail, String>(
        id: 'CategorySpend',
        domainFn: (BalanceDetail item, _) => item.accountName,
        measureFn: (BalanceDetail item, _) => item.balance<0?0:item.balance,
        colorFn: (BalanceDetail item, _) =>
            charts.ColorUtil.fromDartColor(item.color),
        labelAccessorFn: (BalanceDetail spend, _) => spend.balance.toString(),
        data: data,
      )
    ];
  }
}
