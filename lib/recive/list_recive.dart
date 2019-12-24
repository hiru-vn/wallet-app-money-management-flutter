import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:money/home.dart';
import 'package:money/login.dart';
import 'package:money/models/model_url.dart';
import 'package:money/payment/form_payment.dart';
import 'package:money/recive/form_recive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ListRecive extends StatefulWidget {
  @override
  _ListReciveState createState() => _ListReciveState();
}

class _ListReciveState extends State<ListRecive> {
  Dio dio = new Dio();
  ModelUrl modelurl = ModelUrl();

  int userID;
  var listrecive;
  bool isloading = true;

/*========== Login expired ================*/
  Future<Null> checkloginexiped() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyyMMddhm');
    String formatted = formatter.format(now);
    if (int.parse(formatted) >= prefs.getInt('time')) {
      prefs.remove('token');
      prefs.remove('time');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      prefs.setInt('time', int.parse(formatted) + 10);
    }
  }

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

  Future loadlistrecive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int token = await prefs.get('token');
    setState(() {
      userID = token;
    });

    dio.options.connectTimeout = 12000; //5s
    dio.options.receiveTimeout = 12000;
    try {
      Response response = await dio.get('${modelurl.url}api/listrecive');
      if (response.statusCode == 200) {
        //  print(response.data);
        setState(() {
          listrecive = response.data;
          isloading = false;
        });
      }
    } on DioError catch (e) {
      setState(() {
        isloading = false;
      });
      alert('ມີ​ຂ​ໍ້​ຜິດ​ພາດ', 'ກວດ​ເບີ່ງ​ການ​ເຊື່ອມ​ຕໍ່​ເນັ​ດ.!');
    }
  }

/*====================Cormfirt delete ====================*/
  void delcomfirm(var title, var detail, var id) {
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
            FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                delete(id);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

/*================= delete ===================*/
  Future delete(var id) async {
    dio.options.connectTimeout = 12000; //5s
    dio.options.receiveTimeout = 12000;
    try {
      Response response =
          await dio.get('${modelurl.url}api/recivedelete', data: {'id': id});
      if (response.statusCode == 200) {
        //print(response.data);
        setState(() {
          listrecive = response.data;
        });
        isloading = false;
      }
    } on DioError catch (e) {
      isloading = false;
      alert('ມີ​ຂ​ໍ້​ຜິດ​ພາດ', 'ກວດ​ເບີ່ງ​ການ​ເຊື່ອມ​ຕໍ່​ເນັ​ດ.!');
    }
  } 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkloginexiped();
    loadlistrecive();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ລາຍ​ການ​ລາຍຮັບ​ທັງ​ໝົດ'),
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
            onRefresh: loadlistrecive,
            child: isloading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                :ListView.builder(
                    itemCount: listrecive != null ? listrecive.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      final formatter = new NumberFormat("#,###.00");
                      // listpayment[index]['amount']
                      return new Column(
                        children: <Widget>[ 
                          new ListTile(
                            leading: SizedBox(
                                width: 60.0,
                                height: 60.0,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      '${modelurl.urlimg}${listrecive[index]['user']['photo']}'),
                                )),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                IntrinsicHeight(
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
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
                                                listrecive[index]['tyeReceive']
                                                    ['name'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.0,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                formatter.format(int.parse(
                                                        listrecive[index]
                                                            ['amount'])) +
                                                    ' ກີບ',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              Text(
                                                listrecive[index]
                                                    ['description'],
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                                maxLines: 2,
                                              ),
                                              Text(
                                                listrecive[index]['date'],
                                              ),
                                            ],
                                          ),
                                        ),
                                        userID !=
                                                int.parse(listrecive[index]
                                                    ['user_id'])
                                            ? Text('')
                                            : SizedBox(
                                                width: 30.0,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.border_color,
                                                        color: Colors.green,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                fullscreenDialog:
                                                                    true,
                                                                builder: (context) =>
                                                                    FormRecive(
                                                                        listrecive[index]
                                                                            [
                                                                            'id'])));
                                                      },
                                                    ),
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons
                                                            .remove_circle_outline,
                                                        color: Colors.red,
                                                      ),
                                                      onPressed: () {
                                                        delcomfirm(
                                                            'ແຈ້ງ​ເຕືອນ',
                                                            'ທ່ານ​ຕ້ອງ​ການ​ລຶບ​ລາຍ​ການນີ້​ແມ​່ນ​ບໍ.?',
                                                            listrecive[index]
                                                                ['id']);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )
                                      ]),
                                ),
                              ],
                            ),
                          ),
                          new Divider(
                            height: 2.0,
                          ),
                        ],
                      );
                    },
                  ),
          )),
      floatingActionButton: new FloatingActionButton(
          backgroundColor: Colors.green,
          child: new Icon(Icons.add_circle),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => FormRecive(null)));
            /* Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => FormPayment()));*/
          }),
    );
  }
}
