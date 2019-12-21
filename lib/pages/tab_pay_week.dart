import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:intl/intl.dart';
import 'package:money/models/model_url.dart';
import 'dart:async';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class TabPayWeek extends StatefulWidget {
  _TabPayWeekState createState() => _TabPayWeekState();
}

class _TabPayWeekState extends State<TabPayWeek> {
  Dio dio = new Dio();
  ModelUrl modelurl = ModelUrl();
  int pageOffSet = 0;
  int pageSize = 10;
  int allrecode = 10;
  int sum_w = 0;
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

  int i = 0;
  List<Widget> _itemListBuilder(context, entry) {
    final formatter = new NumberFormat("#,###.00");
    if(i==0)
    {
    i= int.parse(entry['id']);
    }
    return [
      i == int.parse(entry['id'])
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
                            'ລວມ​ລາຍ​ຈ່າຍ​ທິດນີ້',
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
                            formatter.format(int.parse('$sum_w')) + ' ​ກີບ',
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
    ];
  }
_getTotal()
  {
    getTotalCount();
    return allrecode;
  }
  @override
  void initState() {
    super.initState();
    getTotalCount();
  }

  Widget build(BuildContext context) {
    return PagewiseListView(
        pageSize: pageSize,
        totalCount: _getTotal(),
        padding: EdgeInsets.all(15.0),
        itemListBuilder: this._itemListBuilder,
        pageFuture: getPageWeek);
  }
}
