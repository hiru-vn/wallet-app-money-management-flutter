import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money/login.dart';
import 'package:money/models/model_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRecieve extends StatefulWidget {
  SearchRecieve({Key key}) : super(key: key);

  _SearchRecieveState createState() => _SearchRecieveState();
}

class _SearchRecieveState extends State<SearchRecieve> {
  var date_start = TextEditingController();
  var date_end = TextEditingController();
  var type_recieve = TextEditingController();
  List listtyperecieve = [''];
  var maptyperecieve;
  var listrecieve;
  var sumrecieve;
  bool isloading = false;
  Dio dio = Dio();
  ModelUrl modelurl = ModelUrl();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkloginexiped();
    loadlisttyperecieve();
  }

  bool ss = true;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ຄົ້ນ​ຫາ​ລາຍ​ຮັບ'),
      ),
      body: sumrecieve == null
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
                          labelText: 'List',
                          suffixIcon: Icon(Icons.date_range),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => _chooseDateEnd(context, date_end.text),
                    child: IgnorePointer(
                      child: TextFormField(
                        // validator: widget.validator,
                        controller: date_end,
                        decoration: InputDecoration(
                          labelText: 'Ink',
                          suffixIcon: Icon(Icons.date_range),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'ເລືອກ​ປະ​ເພດ​ລາຍ​ຮັບ',
                    ),
                    isEmpty: type_recieve.text == null,
                    child: new DropdownButtonHideUnderline(
                      child: new DropdownButton<String>(
                        value: type_recieve.text,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            type_recieve.text = newValue;
                          });
                        },
                        items: listtyperecieve.map((value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  isloading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : RaisedButton.icon(
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
          : ListView.builder(
              itemCount: listrecieve != null ? listrecieve.length : 0,
              itemBuilder: (BuildContext context, int index) {
                final formatter = new NumberFormat("#,###.00");
                // listpayment[index]['amount']
                return new Column(
                  children: <Widget>[
                    index == 0
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
                                          'ລວມ​ລາຍ​ຮັບ',
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
                                          formatter.format(
                                                  int.parse('$sumrecieve')) +
                                              ' ​ກີບ',
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
                            backgroundImage: NetworkImage(
                                '${modelurl.urlimg}${listrecieve[index]['user']['photo']}'),
                          )),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IntrinsicHeight(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          listrecieve[index]['tyeReceive']
                                              ['name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          formatter.format(int.parse(
                                                  listrecieve[index]
                                                      ['amount'])) +
                                              ' ກີບ',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        Text(
                                          listrecieve[index]['description'],
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          maxLines: 2,
                                        ),
                                        Text(
                                          listrecieve[index]['date'],
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
