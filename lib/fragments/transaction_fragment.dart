import 'package:flutter/material.dart';
import 'package:wallet_exe/widgets/card_transaction.dart';

class TransactionFragment extends StatefulWidget {
  TransactionFragment({Key key}) : super(key: key);

  @override
  _TransactionFragmentState createState() => _TransactionFragmentState();
}

class _TransactionFragmentState extends State<TransactionFragment> {
  DateTime selectedDate = DateTime.now();
  List _option = ["Tất cả", "Ví", "ATM", "MoMo"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentOption;

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
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentOption = "Tất cả";
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
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Tài khoản:', style: Theme.of(context).textTheme.subhead,),
                    SizedBox(width: 10,),
                    DropdownButton(
                      value: _currentOption,
                      items: _dropDownMenuItems,
                      onChanged: changedDropDownItem,
                    ),
                  ],
                ),
                RaisedButton(
                  onPressed: () => _selectDate(context),
                  child: Row(
                    children: <Widget>[
                      Text('Tìm ngày'),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.create, size: 20),
                    ],
                  ),
                  color: Theme.of(context).accentColor,
                ),
              ],
            ),
          ),
          CardTransaction(),
          SizedBox(
            height: 15,
          ),
          CardTransaction(),
          SizedBox(
            height: 15,
          ),
          CardTransaction(),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
