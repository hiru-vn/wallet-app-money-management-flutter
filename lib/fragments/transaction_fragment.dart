import 'package:flutter/material.dart';

class TransactionFragment extends StatefulWidget {
  TransactionFragment({Key key}) : super(key: key);

  @override
  _TransactionFragmentState createState() => _TransactionFragmentState();
}

class _TransactionFragmentState extends State<TransactionFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('Transaction'),
    );
  }
}