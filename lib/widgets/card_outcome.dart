import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:wallet_exe/widgets/item_spend_chart_circle.dart';

class CardOutcomeChart extends StatefulWidget {
  CardOutcomeChart({Key key}) : super(key: key);

  @override
  _CardOutcomeChartState createState() => _CardOutcomeChartState();
}

class _CardOutcomeChartState extends State<CardOutcomeChart> {
  List _option = ["Hôm nay", "Tuần này", "Tháng này", "Năm nay"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentOption;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentOption = "Tháng này";
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
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Biểu đồ chi', style: Theme.of(context).textTheme.title),
              DropdownButton(
                value: _currentOption,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 320,
            width: double.infinity,
            child: SpendChartCircle(_createSampleData()),
          ),
          Text('Đơn vị: nghìn'),
          // Expanded(
          //   flex: 1,
          //   child: Column(
          //     children: <Widget>[

          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  static List<charts.Series<CategorySpend, String>> _createSampleData() {
    final List<Color> colors = [
      // Color(0x7adfeeee),
      // Color(0xffffd54f),
      // Color(0xff80deea),
      // Color(0xffef9a9a),
      // Color(0xeec5c68a),
      // Color(0xfff8bbd0),
      // Color(0xffbbdefb),
      Colors.red,
      Colors.pinkAccent,
      Colors.blueAccent,
      Colors.green,
      Colors.purpleAccent,
      Colors.amberAccent,
      Colors.black54,
    ];

    final data = [
      CategorySpend('Ăn uống', 5),
      CategorySpend('Đi lại', 25),
      CategorySpend('Du lịch', 100),
      CategorySpend('Học phí', 75),
      CategorySpend('Người yêu', 75),
      CategorySpend('Con cái', 175),
      CategorySpend('khác', 5),
    ];

    for (int i = 0; i < 7; i++) {
      data[i].color = colors[i];
    }

    return [
      new charts.Series<CategorySpend, String>(
        id: 'CategorySpend',
        domainFn: (CategorySpend spend, _) => spend.category,
        measureFn: (CategorySpend spend, _) => spend.money,
        colorFn: (CategorySpend spend, _) =>
            charts.ColorUtil.fromDartColor(spend.color),
        labelAccessorFn: (CategorySpend spend, _) => spend.money.toString(),
        data: data,
      )
    ];
  }
}

class categoryItem extends StatelessWidget {
  final CategorySpend _item;
  const categoryItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 10,
          height: 10,
          child: DecoratedBox(
            decoration: BoxDecoration(color: _item.color),
          ),
        ),
        Text(_item.category),
      ],
    );
  }
}
