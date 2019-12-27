import 'package:flutter/material.dart';
import 'package:wallet_exe/widgets/card_earn_chart.dart';
import 'package:wallet_exe/widgets/card_maximum_spend.dart';
import 'package:wallet_exe/widgets/card_outcome.dart';
import 'package:wallet_exe/widgets/card_spend_chart.dart';

class ChartFragment extends StatefulWidget {
  ChartFragment({Key key}) : super(key: key);

  @override
  _ChartFragmentState createState() => _ChartFragmentState();
}

class _ChartFragmentState extends State<ChartFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        CardMaximunSpend(),
        SizedBox(
          height: 15,
        ),
        CardOutcomeChart(),
        SizedBox(
          height: 15,
        ),
        CardSpendChart(showDetail: true,),
        SizedBox(
          height: 15,
        ),
        CardEarnChart(showDetail: true,),
        SizedBox(
          height: 60,
        ),
      ],
    ));
  }
}
