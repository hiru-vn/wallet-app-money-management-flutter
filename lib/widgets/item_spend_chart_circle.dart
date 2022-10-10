import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SpendChartCircle extends StatelessWidget {
  final List<charts.Series> _seriesList;
  final bool animate;

  SpendChartCircle(this._seriesList, {this.animate});

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
          horizontalFirst: false,
          desiredMaxRows: 2,
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

class CategorySpend {
  final String category;
  int money;
  Color color;

  CategorySpend(this.category, this.money, {this.color = Colors.blueAccent});
}
