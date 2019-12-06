import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Cardbalance extends StatefulWidget {
  Cardbalance({Key key}) : super(key: key);

  @override
  _CardbalanceState createState() {
    return _CardbalanceState();
  }
}

class _CardbalanceState extends State<Cardbalance> {
  List _option = ["Hôm nay", "Tuần này", "Tháng này", "Năm nay"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentOption;
  double inCome = 1000000;
  double outCome = 2000000;

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
      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(top: 12),
                child: Column(
                  children: <Widget>[
                    Text('Tình hình thu chi',
                        style: Theme.of(context).textTheme.title),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 150,
                            width: ScreenUtil.getInstance().setWidth(120),
                            color: Colors.red,
                          ),
                          Container(
                            height: 100,
                            width: ScreenUtil.getInstance().setWidth(120),
                            color: Colors.green,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
          Expanded(
            flex: 6,
            child: Column(
              children: <Widget>[
                DropdownButton(
                  value: _currentOption,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem,
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 5.0,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Thu', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          Text(
                            inCome.toString() + ' đ',
                            style: TextStyle(color: Colors.green, fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 5.0,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Chi', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          Text(
                            outCome.toString() + ' đ',
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Tích lũy', style: TextStyle(fontSize: 16)),
                          Text(
                            (inCome - outCome).toString() + ' đ',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Xem ghi chép",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Icon(Icons.navigate_next,color: Colors.blue,)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
