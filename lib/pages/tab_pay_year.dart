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
