import 'package:flutter/material.dart';
import 'package:wallet_exe/custom_toolbox/message_label.dart';

class CardMaximunSpendItem extends StatefulWidget {
  CardMaximunSpendItem({Key key}) : super(key: key);

  @override
  _CardMaximunSpendItemState createState() => _CardMaximunSpendItemState();
}

class _CardMaximunSpendItemState extends State<CardMaximunSpendItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
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
                children: <Widget>[
                  Text('Hàng tháng', style: Theme.of(context).textTheme.title),
                  Text('19/11 - 18/12'),
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text('3.200.000 đ', style: Theme.of(context).textTheme.title),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.all(3.0),
          decoration:
              BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.all(new Radius.circular(5.0)),
              ),
          child: Text("Hôm nay"),
        ),
        Container(
          child: CustomPaint(
            painter: TrianglePainter(
              strokeColor: Theme.of(context).accentColor,
              strokeWidth: 10,
              paintingStyle: PaintingStyle.fill,
            ),
            child: Container(
              height: 8,
              width: 8,
            ),
          ),
        ),
        LinearProgressIndicator(
          value: 0.5,
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Còn 12 ngày'),
            Text('3.180.000 đ'),
          ],
        ),
      ],
    );
  }
}
