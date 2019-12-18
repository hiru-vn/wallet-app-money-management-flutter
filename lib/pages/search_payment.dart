import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money/login.dart';
import 'package:money/models/model_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPayment extends StatefulWidget {
  SearchPayment({Key key}) : super(key: key);

  _SearchPaymentState createState() => _SearchPaymentState();
}

class _SearchPaymentState extends State<SearchPayment> {
  var date_start = TextEditingController();
  var date_end = TextEditingController();
  var type_pay = TextEditingController();
  List listtypepay = [''];
  var maptypepay;
  var listpayment;
  var sumpayment;
  bool isloading=false;
  Dio dio = Dio();
  ModelUrl modelurl = ModelUrl();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkloginexiped();
    loadlisttypepayment();
  }

  bool ss = true;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ຄົ້ນ​ຫາ​ລາຍ​ຈ່າຍ'),
      ),
      body: sumpayment == null
          ? Container(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  InkWell(
                    onTap: () => _chooseDate(context, date_start.text),
                    child: IgnorePointer(
                      child: TextFormField(
                        // validator: widget.validator,
                        controller: date_start,
                        decoration: InputDecoration(
                          labelText: 'ວັນ​ທີ່ເລີ່ມ​',
                          suffixIcon: Icon(Icons.date_range),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  isloading?Center(child: CircularProgressIndicator(),)
                  :RaisedButton.icon(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    label: Text(
                      'ຄົ້ນ​ຫາ',
                      style: TextStyle(color: Colors.white),
                    ),
                    key: null,
                    onPressed: () {
                      searchpayment();
                    },
                    // onPressed: loginpress,
                    color: Colors.blue,
                  ),
                ],
              ),
            )
    );
  }
}
