import 'package:flutter/material.dart';
import 'package:wallet_exe/widgets/item_transaction.dart';

class CardTransaction extends StatelessWidget {
  const CardTransaction({Key key}) : super(key: key);  

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
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Hôm nay",style: Theme.of(context).textTheme.title,),
            Text("7/12/2019",style: Theme.of(context).textTheme.subtitle,),
          ],
        ),
        children: <Widget>[
          ItemTransaction('assets/bank.png', 'lãi tiết kiêm', 1500000),
          ItemTransaction('assets/bank.png', 'ăn uống', -1500000),
          ItemTransaction('assets/bank.png', 'du lịch', 1500000),
          ItemTransaction('assets/bank.png', 'mua sắm', 1500000),
        ],
      )
    );
  }
}
