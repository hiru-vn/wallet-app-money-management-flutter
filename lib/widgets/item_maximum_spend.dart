import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wallet_exe/custom_toolbox/message_label.dart';
import 'package:wallet_exe/data/dao/transaction_table.dart';
import 'package:wallet_exe/data/model/SpendLimit.dart';
import 'package:wallet_exe/enums/spend_limit_type.dart';
import 'package:wallet_exe/pages/spend_limit_page.dart';
import 'package:wallet_exe/utils/text_input_formater.dart';

class MaximunSpendItem extends StatelessWidget {
  final SpendLimit _spendLimit;
  const MaximunSpendItem(this._spendLimit);

  String _getTimelineString() {
    switch (_spendLimit.type) {
      case SpendLimitType.WEEKLY:
        final now = DateTime.now();
        DateTime firstDay = now.add(Duration(days: -(now.weekday - 1)));
        DateTime lastDay = now.add(Duration(days: 7 - now.weekday));
        return firstDay.day.toString() +
            '/' +
            firstDay.month.toString() +
            ' - ' +
            lastDay.day.toString() +
            '/' +
            lastDay.month.toString();
      case SpendLimitType.MONTHLY:
        final now = DateTime.now();
        final lastDay = (now.month < 12)
            ? new DateTime(now.year, now.month + 1, 0)
            : new DateTime(now.year + 1, 1, 0);

        return '1/' +
            now.month.toString() +
            ' - ' +
            lastDay.day.toString() +
            '/' +
            now.month.toString();
      case SpendLimitType.QUATERLY:
        int th = DateTime.now().month ~/ 3;
        if ((DateTime.now().month % 3) != 0) th += 1;
        DateTime firstDay;
        DateTime lastDay;
        switch (th) {
          case 1:
            firstDay = DateTime(DateTime.now().year, 1, 1);
            lastDay = DateTime(DateTime.now().year, 3, 31);
            break;
          case 2:
            firstDay = DateTime(DateTime.now().year, 1, 4);
            lastDay = DateTime(DateTime.now().year, 6, 30);
            break;
          case 3:
            firstDay = DateTime(DateTime.now().year, 1, 7);
            lastDay = DateTime(DateTime.now().year, 9, 30);
            break;
          case 4:
            firstDay = DateTime(DateTime.now().year, 1, 10);
            lastDay = DateTime(DateTime.now().year, 12, 31);
            break;
        }
        return firstDay.day.toString() +
            '/' +
            firstDay.month.toString() +
            ' - ' +
            lastDay.day.toString() +
            '/' +
            lastDay.month.toString();
      case SpendLimitType.YEARLY:
        return '1/1 - 31/12';
    }
    return '';
  }

  String _getDaysLeft() {
    if (_spendLimit.type == SpendLimitType.WEEKLY) {
      return (7 - DateTime.now().weekday).toString();
    } else if (_spendLimit.type == SpendLimitType.MONTHLY) {
      final now = DateTime.now();
      final lastDay = (now.month < 12)
          ? new DateTime(now.year, now.month + 1, 0)
          : new DateTime(now.year + 1, 1, 0);
      return (lastDay.day - now.day).toString();
    } else if (_spendLimit.type == SpendLimitType.QUATERLY) {
      int th = DateTime.now().month ~/ 3;
      if ((DateTime.now().month % 3) != 0) th += 1;
      DateTime lastDay;
      switch (th) {
        case 1:
          lastDay = DateTime(DateTime.now().year, 3, 31);
          break;
        case 2:
          lastDay = DateTime(DateTime.now().year, 6, 30);
          break;
        case 3:
          lastDay = DateTime(DateTime.now().year, 9, 30);
          break;
        case 4:
          lastDay = DateTime(DateTime.now().year, 12, 31);
          break;
      }
      return lastDay.difference(DateTime.now()).inDays.toString();
    } else {
      return (365 - Jiffy(DateTime.now()).dayOfYear).toString();
    }
  }

  EdgeInsets _getMarginBubble(double containerWidth) {
    try {
      if (_spendLimit.type == SpendLimitType.WEEKLY) {
        //return (7 - DateTime.now().weekday).toString();
        double scale = (DateTime.now().weekday - 3.5) / 7;
        if (scale >= 0) {
          if ((scale * containerWidth * 1.9).abs() > 20) {
            return EdgeInsets.only(
                left: (scale * containerWidth * 1.9).abs() - 20);
          } else
            return EdgeInsets.zero;
        } else {
          if ((scale * containerWidth * 1.9).abs() > 20) {
            return EdgeInsets.only(
                right: (scale * containerWidth * 1.9).abs() - 20);
          } else {
            return EdgeInsets.zero;
          }
        }
      }
      // to do
      final now = DateTime.now();
      final lastDay = (now.month < 12)
          ? new DateTime(now.year, now.month + 1, 0)
          : new DateTime(now.year + 1, 1, 0);
      double scale = (now.day - lastDay.day / 2 - 0.5) / lastDay.day;
      if (scale >= 0) {
        if ((scale * containerWidth * 1.9).abs() > 20) {
          return EdgeInsets.only(
              left: (scale * containerWidth * 1.9).abs() - 20);
        } else
          return EdgeInsets.zero;
      } else if (scale < 0) {
        if ((scale * containerWidth * 1.9).abs() > 20) {
          return EdgeInsets.only(
              right: (scale * containerWidth * 1.9).abs() - 20);
        } else
          return EdgeInsets.zero;
      }
      return EdgeInsets.only(left: 190);
    } catch (e) {
      return EdgeInsets.zero;
    }
  }

  EdgeInsets _prevent2Lines() {
    final now = DateTime.now();
    final lastDay = (now.month < 12)
        ? new DateTime(now.year, now.month + 1, 0)
        : new DateTime(now.year + 1, 1, 0);
    if (now.day == 1) return EdgeInsets.only(left: 10);
    if (now.day == lastDay.day) return EdgeInsets.only(right: 10);
    return EdgeInsets.all(0);
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width - 30;

    void _nav() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SpendLimitPage(this._spendLimit)),
      );
    }

    return FutureBuilder(
      future: TransactionTable().getMoneySpendByDuration(_spendLimit.type),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              InkWell(
                onTap: _nav,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Icon(
                        Icons.fastfood,
                        size: 35,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(this._spendLimit.type.name,
                              style: Theme.of(context).textTheme.title),
                          Text(_getTimelineString()),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                              textToCurrency(_spendLimit.amount.toString()) +
                                  ' đ',
                              style: Theme.of(context).textTheme.title),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: _getMarginBubble(containerWidth) ?? EdgeInsets.zero,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: _prevent2Lines(),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius:
                            BorderRadius.all(new Radius.circular(5.0)),
                      ),
                      child: Text("Hôm nay", maxLines: 1),
                    ),
                    Container(
                      child: CustomPaint(
                        painter: TrianglePainter(
                          strokeColor: Theme.of(context).accentColor,
                          strokeWidth: 10,
                          paintingStyle: PaintingStyle.fill,
                        ),
                        child: Container(
                          height: 7,
                          width: 7,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.black38,
                  value: snapshot.data > this._spendLimit.amount
                      ? 1
                      : snapshot.data / this._spendLimit.amount,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Còn ' + _getDaysLeft() + ' ngày'),
                  Text(textToCurrency(
                      (this._spendLimit.amount - snapshot.data).toString())),
                ],
              ),
            ],
          );
        }
        return Container(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
