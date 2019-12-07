import 'package:flutter/material.dart';

class TransactionFragment extends StatefulWidget {
  TransactionFragment({Key key}) : super(key: key);

  @override
  _TransactionFragmentState createState() => _TransactionFragmentState();
}

class _TransactionFragmentState extends State<TransactionFragment> {
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         children: <Widget>[
           RaisedButton(
                    onPressed: () => _selectDate(context),
                    child: Row(
                      children: <Widget>[
                        Text('Chọn năm'),
                        SizedBox(width: 5,),
                        Icon(Icons.create,size: 20),
                      ],
                    ),
                    color: Theme.of(context).accentColor,
                  ),
         ],
       ),
    );
  }
}