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
  
  /*==================== Load list type payment  ==================*/
  Future loadlisttypepayment() async {
    dio.options.connectTimeout = 12000; //5s
    dio.options.receiveTimeout = 12000;
    try {
      Response response = await dio.get('${modelurl.url}api/listtypepay');
      if (response.statusCode == 200) {
        for (var item in response.data) {
          listtypepay.add('${item['name']}');
        }
        setState(() {
          maptypepay = response.data;
          listtypepay = listtypepay;
        });
      }
    } on DioError catch (e) {
      alert('ມີ​ຂ​ໍ້​ຜິດ​ພາດ', 'ກວດ​ເບີ່ງ​ການ​ເຊື່ອມ​ຕໍ່​ເນັ​ດ.!');
    }
  }

  /*============== alert ======================*/
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

  /*===================== Select date picker =================*/
  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(2018),
        lastDate: new DateTime(9999));

    if (result == null) return;

    setState(() {
      date_start.text = new DateFormat.yMd().format(result);
    });
  }

  Future _chooseDateEnd(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(2018),
        lastDate: new DateTime(9999));

    if (result == null) return;

    setState(() {
      date_end.text = new DateFormat.yMd().format(result);
    });
  }

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  Future searchpayment() async {
    setState(() {
     isloading=true; 
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int token = await prefs.get('token');
    var type_id;
    for (var item in maptypepay) {
      if (item['name'] == type_pay.text) {
        type_id = item['id'];
      }
    }
    dio.options.connectTimeout = 12000; //5s
    dio.options.receiveTimeout = 12000;
    FormData formData = new FormData.from({
      'type_id': type_id,
      'date_start': date_start.text,
      'date_end':
          date_end.text, // use for create or update if id=null is create
    });
    try {
      Response response = await dio.post('${modelurl.url}api/listpaymentsearch',
          data: formData);
      Response responsesum = await dio
          .post('${modelurl.url}api/countpaymentsearch', data: formData);
      if (response.statusCode == 200) {
        setState(() {
          isloading=false;
          listpayment = response.data;
          sumpayment = responsesum.data['sum'];
        });
      }
    } on DioError catch (e) {
      setState(() {
        isloading=false;
      });
      alert('ມີ​ຂ​ໍ້​ຜິດ​ພາດ', 'ກວດ​ເບີ່ງ​ການ​ເຊື່ອມ​ຕໍ່​ເນັ​ດ.!');
    }
  }

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
                  InkWell(
                    onTap: () => _chooseDateEnd(context, date_end.text),
                    child: IgnorePointer(
                      child: TextFormField(
                        // validator: widget.validator,
                        controller: date_end,
                        decoration: InputDecoration(
                          labelText: 'ວັນ​ທີ່ສ​ຸດ​ທ້າຍ​',
                          suffixIcon: Icon(Icons.date_range),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'ເລືອກ​ປະ​ເພດ​ລາຍ​ຈ່າຍ',
                    ),
                    isEmpty: type_pay.text == null,
                    child: new DropdownButtonHideUnderline(
                      child: new DropdownButton<String>(
                        value: type_pay.text,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            type_pay.text = newValue;
                          });
                        },
                        items: listtypepay.map((value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
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
          : ListView.builder(
              itemCount: listpayment != null ? listpayment.length : 0,
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
                                          'ລວມ​ລາຍ​ຈ່າຍ',
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
                                                  int.parse('$sumpayment')) +
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
                                '${modelurl.urlimg}${listpayment[index]['user']['photo']}'),
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
                                          listpayment[index]['typePay']['name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          formatter.format(int.parse(
                                                  listpayment[index]
                                                      ['amount'])) +
                                              ' ກີບ',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        Text(
                                          listpayment[index]['description'],
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          maxLines: 2,
                                        ),
                                        Text(
                                          listpayment[index]['date'],
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
