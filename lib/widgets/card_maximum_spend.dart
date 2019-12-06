import 'package:flutter/material.dart';
import 'package:wallet_exe/widgets/item_maximum_spend.dart';

class CardMaximunSpend extends StatefulWidget {
  CardMaximunSpend({Key key}) : super(key: key);

  @override
  _CardMaximunSpendState createState() => _CardMaximunSpendState();
}

class _CardMaximunSpendState extends State<CardMaximunSpend> {
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
                Text('Hạn mức chi',
                    style: Theme.of(context).textTheme.title),
                Icon(Icons.settings),
              ],
            ),

            SizedBox(height: 10,),

            CardMaximunSpendItem(),
          ],
        ));
  }
}
