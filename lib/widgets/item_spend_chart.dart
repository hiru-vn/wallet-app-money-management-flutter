import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';


class SpendChart extends StatelessWidget {
  final List<charts.Series> _seriesList;
  final bool animate;

  SpendChart(this._seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      _seriesList,
      animate: animate,
      animationDuration: Duration(milliseconds: 500),
    );
  }
}

class MoneySpend {
  final int month;
  final int money;

  MoneySpend(this.month, this.money);
}
