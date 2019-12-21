import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:intl/intl.dart';
import 'package:money/models/model_url.dart';
import 'dart:async';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class TabPayYear extends StatefulWidget {
  _TabPayYearState createState() => _TabPayYearState();
}

class _TabPayYearState extends State<TabPayYear> {
  Dio dio = new Dio();
  ModelUrl modelurl = ModelUrl();
  int pageOffSet = 0;
  int pageSize = 10;
  int allrecode =0;
  int sum = 0;
  /* ==================== alert ==============*/
  void alert(var title, var detail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Center(
              child: new Text("${title}",
                  style: TextStyle(fontSize: 20.0, color: Colors.red))),
          content: new Text("${detail}"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("ປິດ"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future getTotalCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int token = await prefs.get('token');
    try {
      Response response =
          await dio.get('${modelurl.url}api/countpayyearrecode');
      if (response.statusCode == 200) {
       // print(response.data['count']);
        setState(() {
          allrecode = int.parse(response.data['count']);
          sum = int.parse(response.data['sum']);
        });
      }
    } on DioError catch (e) {
      alert('ມີ​ຂ​ໍ້​ຜິດ​ພາດ', 'ກວດ​ເບີ່ງ​ການ​ເຊື່ອມ​ຕໍ່​ເນັ​ດ.!');
    }
  }
  _getTotal()
  {
    getTotalCount();
    return allrecode;
  }

  Future<List> getPageMonth(pageIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int token = await prefs.get('token');
    try {
      Response response = await dio.get(
          '${modelurl.url}api/listpaymentyearpage&pageoffset=$pageOffSet&pagesize=$pageSize');
      if (response.statusCode == 200) {
        setState(() {
          pageOffSet = pageOffSet+10;
          print(pageOffSet);
        });
        // print(response.data);
        return response.data;
      }
    } on DioError catch (e) {
      alert('ມີ​ຂ​ໍ້​ຜິດ​ພາດ', 'ກວດ​ເບີ່ງ​ການ​ເຊື່ອມ​ຕໍ່​ເນັ​ດ.!');
    }
  }
  int i=0;
  List<Widget> _itemListBuilder(context, entry) {
    final formatter = new NumberFormat("#,###.00");
    if(i==0)
    {
    i= int.parse(entry['id']);
    }
    return [
      i== int.parse(entry['id'])
          ? Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: Container(
                      padding: EdgeInsets.only(top: 5.0),
                      color: Colors.yellow,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'ລວມ​ລາຍ​ຈ່າຍ​ເປັນ​ປີ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: Container(
                      padding: EdgeInsets.only(top: 5.0),
                      color: Colors.red,
                      child: Column(
                        children: <Widget>[
                          Text(
                            formatter.format(int.parse('$sum')) + ' ​ກີບ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Divider(),
      ListTile(
        leading: SizedBox(
            width: 60.0,
            height: 60.0,
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage('${modelurl.urlimg}${entry['user']['photo']}'),
            )),
        title: Text(
          entry['typePay']['name'],
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.black),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              formatter.format(int.parse(entry['amount'])) + ' ກີບ',
              style: TextStyle(color: Colors.red),
            ),
            Text(
              entry['description'],
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 2,
            ),
            Text(
              entry['date'],
            ),
          ],
        ),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
   // getTotalCount();
  }

  Widget build(BuildContext context) {
    
    return PagewiseListView(
        pageSize: pageSize,
        totalCount: _getTotal(),
        padding: EdgeInsets.all(15.0),
        itemListBuilder: this._itemListBuilder,
        pageFuture: getPageMonth);
  }
}
