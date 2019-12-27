import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class BalanceChartCircle extends StatelessWidget {
  final List<charts.Series> _seriesList;
  final bool animate;

  BalanceChartCircle(this._seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(
      _seriesList,
      animate: animate,
      animationDuration: Duration(milliseconds: 500),
      defaultRenderer: charts.ArcRendererConfig(
        arcWidth: 60,
        arcRendererDecorators: [
          charts.ArcLabelDecorator(
            labelPosition: charts.ArcLabelPosition.outside
          )
        ]
      ),
      behaviors: [
        charts.DatumLegend(
          position: charts.BehaviorPosition.bottom,
          outsideJustification: charts.OutsideJustification.endDrawArea,
          horizontalFirst: true,
          cellPadding: EdgeInsets.only(right: 10,bottom: 10),
          entryTextStyle: charts.TextStyleSpec(
            color: charts.MaterialPalette.purple.shadeDefault,
            fontSize: 12,
          )
        )
      ],
    );
  }
}

class BalanceDetail {
  final String accountName;
  int balance;
  Color color;

  BalanceDetail(this.accountName, this.balance, {this.color = Colors.blueAccent});
}
