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

  @override
  void initState() {
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
                      labelText: 'Enter',
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
                      labelText: 'enter',
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
                      labelText: 'enter',
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
                          labelText: 'enter',
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
