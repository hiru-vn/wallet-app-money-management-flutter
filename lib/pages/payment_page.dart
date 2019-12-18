import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:money/home.dart';
import 'package:money/login.dart';
import 'package:money/models/model_url.dart';
import 'package:money/payment/form_payment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ListPayment extends StatefulWidget {
  @override
  _ListPaymentState createState() => _ListPaymentState();
}

class _ListPaymentState extends State<ListPayment> {
  Dio dio = new Dio();
  ModelUrl modelurl = ModelUrl();

  int userID;
  var listpayment;
  bool isloading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkloginexiped();
    loadlistpayment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ລາຍ​ການ​ລາຍ​ຈ່າຍ​ທັງ​ໝົດ'),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
            }),
      ),
      body: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: RefreshIndicator(
            onRefresh: loadlistpayment,
            child: isloading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
          )),
      floatingActionButton: new FloatingActionButton(
          backgroundColor: Colors.red,
          child: new Icon(Icons.add_circle),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => FormPayment(null)));
            /* Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => FormPayment()));*/
          }),
    );
  }
}
