import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_exe/utils/text_input_formater.dart';

class AddAccountPage extends StatefulWidget {
  AddAccountPage({Key key}) : super(key: key);

  @override
  _AddAccountPageState createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {

  List _option = ["Tài khoản tiêu dùng", "Tài khoản tiết kiệm"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentOption;

  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentOption = "Tài khoản tiêu dùng";
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

  _submit() {
    //add data
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 1080, height: 1920, allowFontScaling: true);
    return Scaffold(
        appBar: AppBar(
          title: Text('Tạo tài khoản mới'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _submit,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  width: double.infinity,
                  child: TextField(
                    autofocus: true,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        hintText: 'Tên tài khoản',
                        hintStyle: TextStyle(fontSize: 20),
                        icon: Icon(
                          Icons.account_balance_wallet,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  width: double.infinity,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [CurrencyTextFormatter()],
                    autofocus: true,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        suffixText: 'đ',
                        hintText: 'Số dư ban đầu',
                        hintStyle: TextStyle(fontSize: 20),
                        icon: Icon(
                          Icons.attach_money,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('Loại hạng mục', style: TextStyle(fontSize: 18,color: Colors.black.withOpacity(0.5)),),
                      SizedBox(width: 15),
                      DropdownButton(
                        value: _currentOption,
                        items: _dropDownMenuItems,
                        onChanged: changedDropDownItem,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  width: double.infinity,
                  child: TextField(
                    autofocus: true,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        hintText: 'Diễn giải',
                        hintStyle: TextStyle(fontSize: 20),
                        icon: Icon(
                          Icons.subject,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        )),
                  ),
                ),
                
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.save_alt,
                            size: 28,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Tạo',
                            style: Theme.of(context).textTheme.title,
                          ),
                        ],
                      ),
                    ),
                    onPressed: _submit,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
