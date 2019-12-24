import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money/login.dart';
import 'package:money/models/model_payment.dart';
import 'package:money/models/model_recive.dart';
import 'package:money/models/model_type_pay.dart';
import 'package:money/models/model_type_recive.dart';
import 'package:money/models/model_url.dart';
import 'package:money/payment/list_payment.dart';
import 'package:money/recive/list_recive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormRecive extends StatefulWidget {
  var id;
  FormRecive(this.id);
  @override
  _FormReciveState createState() => _FormReciveState(this.id);
}

class _FormReciveState extends State<FormRecive> {
  var id;
  _FormReciveState(this.id);
  ModelRecive modelrecive = ModelRecive();
  ModelUrl modelurl = ModelUrl();
  ModelTypeRecive modeltyperecive = ModelTypeRecive();
  Dio dio = Dio();

  List listtyperecive = [''];
  var maptyperecive;
  bool isloading = true;
  bool isloadingsave = false;

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
  /* ======================= alert ==========================*/
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

/*==================== Load data payment show to field  ==================*/
  Future loaddatapayment() async {
    if (id != null) {
      dio.options.connectTimeout = 12000; //5s
      dio.options.receiveTimeout = 12000;
      try {
        Response response =
            await dio.get('${modelurl.url}api/listrecivepk', data: {'id': id});
        if (response.statusCode == 200) {
          setState(() {
            modelrecive.controller_amount.text = response.data['amount']+'.00';
            modelrecive.controller_description.text =
                response.data['description'];
            modelrecive.controller_date.text = response.data['date'];
            modelrecive.controller_type_recive_id.text =
                response.data['tyeReceive']['name'];
          });
        }
      } on DioError catch (e) {
        isloading = false;
        alert('ມີ​ຂ​ໍ້​ຜິດ​ພາດ', 'ກວດ​ເບີ່ງ​ການ​ເຊື່ອມ​ຕໍ່​ເນັ​ດ.!');
      }
    }
  }

/*==================== Load list type payment  ==================*/
  Future loadlisttypepayment() async {
    dio.options.connectTimeout = 12000; //5s
    dio.options.receiveTimeout = 12000;
    try {
      Response response = await dio.get('${modelurl.url}api/listtyperecive');
      if (response.statusCode == 200) {
        for (var item in response.data) {
          listtyperecive.add('${item['name']}');
        }
        setState(() {
          maptyperecive = response.data;
          listtyperecive = listtyperecive;
        });
        isloading = false;
      }
    } on DioError catch (e) {
      isloading = false;
      alert('ມີ​ຂ​ໍ້​ຜິດ​ພາດ', 'ກວດ​ເບີ່ງ​ການ​ເຊື່ອມ​ຕໍ່​ເນັ​ດ.!');
    }
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
      modelrecive.controller_date.text = new DateFormat.yMd().format(result);
      modelrecive.date = modelrecive.controller_date.text;
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

/* ================= Save datata ==============*/
  Future save() async {
    setState(() {
      isloadingsave = true;
    });
    // print(id);
    var type_id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userID = await prefs.get('token');
    dio.options.connectTimeout = 12000; //5s
    dio.options.receiveTimeout = 12000;
    for (var item in maptyperecive) {
      if (item['name'] == modelrecive.controller_type_recive_id.text) {
        type_id = item['id'];
      }
    }

    FormData formData = new FormData.from({
      'type_id': type_id,
      'amount': modelrecive.controller_amount.text,
      'description': modelrecive.controller_description.text,
      'date': modelrecive.controller_date.text,
      'user_id': userID,
      'id': id, // use for create or update if id=null is create
    });
    try {
      Response response = await dio
          .post('${modelurl.url}api/createorupdaterecive', data: formData);
      if (response.statusCode == 200) {
        setState(() {
          isloadingsave = false;
        });
        if (response.data == true) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ListRecive()));
        } else {
          alert('ມີ​ຂ​ໍ້​ຜິດ​ພາດ', response.data);
        }
      }
    } on DioError catch (e) {
      setState(() {
        isloadingsave = false;
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
    loaddatapayment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            id == null ? Text('ປ້ອນ​​ລາ​ຍ​​ຮັບ') : Text('​​​ແກ້​ໄຂລາ​ຍ​​ຮັບ'),
      ),
      body: new Container(
        child: isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                padding: EdgeInsets.only(top: 50.0),
                children: <Widget>[
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'ເລືອກ​ປະ​ເພດ​ລາຍ​ຮັບ​',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    isEmpty: modelrecive.controller_type_recive_id.text == null,
                    child: new DropdownButtonHideUnderline(
                      child: new DropdownButton<String>(
                        value: modelrecive.controller_type_recive_id.text,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            modelrecive.controller_type_recive_id.text =
                                newValue;
                          });
                        },
                        items: listtyperecive.map((value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: modelrecive.controller_amount,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'ຈ​ຳ​ນວນ​ເງີນຮັບ',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    onChanged: (value) {
                      modelrecive.amount = value;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: modelrecive.controller_description,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'ອະ​ທີ​ບາຍ​ຮັບຍັງ',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  InkWell(
                    onTap: () =>
                        _chooseDate(context, modelrecive.controller_date.text),
                    child: IgnorePointer(
                      child: TextFormField(
                        // validator: widget.validator,
                        controller: modelrecive.controller_date,
                        decoration: InputDecoration(
                          labelText: 'ວັນ​ທີ່​ຮັບ',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          suffixIcon: Icon(Icons.date_range),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  isloadingsave
                      ? Center(child: CircularProgressIndicator())
                      : RaisedButton.icon(
                          color: Colors.blue,
                          label: Text(
                            'ບັນ​ທຶກ',
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            save();
                          },
                        )
                ],
              ),
        padding: const EdgeInsets.all(5.0),
        alignment: Alignment.center,
      ),
    );
  }
}
