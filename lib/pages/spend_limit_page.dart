import 'package:flutter/material.dart';
import 'package:wallet_exe/bloc/spend_limit_bloc.dart';
import 'package:wallet_exe/data/model/SpendLimit.dart';
import 'package:wallet_exe/event/spend_limit_event.dart';
import 'package:wallet_exe/pages/spend_limit_type_page.dart';
import 'package:wallet_exe/utils/text_input_formater.dart';

class SpendLimitPage extends StatefulWidget {
  final SpendLimit _spendLimit;
  SpendLimitPage(this._spendLimit);

  @override
  _SpendLimitPageState createState() => _SpendLimitPageState();
}

class _SpendLimitPageState extends State<SpendLimitPage> {
  var _spendLimitController = TextEditingController();
  var _formspendLimitKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var _bloc = SpendLimitBloc();
    _bloc.initData();

    _submit() {
      if (!this._formspendLimitKey.currentState.validate()) {
        return;
      }

      SpendLimit item = SpendLimit(
          currencyToInt(_spendLimitController.text), widget._spendLimit.type);
      item.id = widget._spendLimit.id;
      _bloc.event.add(UpdateSpendLimitEvent(item));

      Navigator.pop(context);
    }

    _delete() {
      if (!this._formspendLimitKey.currentState.validate()) {
        return;
      }

      SpendLimit item = SpendLimit(
          currencyToInt(_spendLimitController.text), widget._spendLimit.type);
      item.id = widget._spendLimit.id;
      _bloc.event.add(DeleteSpendLimitEvent(item));

      Navigator.pop(context);
    }

    _chooseType() async {
      var temp = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SpendLimitTypePage(widget._spendLimit.type)),
      );

      // prevent null
      if (temp!= null) widget._spendLimit.type = temp;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Sửa hạn mức'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _submit,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark? Colors.blueGrey: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 15.0),
                        blurRadius: 15.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hạn mức',
                        style: Theme.of(context).textTheme.title,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Form(
                              key: _formspendLimitKey,
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.trim() == "")
                                    return 'Số tiền phải lớn hơn 0';
                                  return currencyToInt(value) <= 0
                                      ? 'Số tiền phải lớn hơn 0'
                                      : null;
                                },
                                controller: _spendLimitController,
                                textAlign: TextAlign.end,
                                inputFormatters: [CurrencyTextFormatter()],
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900),
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: true, decimal: true),
                                autofocus: true,
                                decoration: InputDecoration(
                                  suffixText: 'đ',
                                  suffixStyle:
                                      Theme.of(context).textTheme.headline,
                                  prefix: Icon(
                                    Icons.monetization_on,
                                    color: Theme.of(context).accentColor,
                                    size: 26,
                                  ),
                                  hintText: '0',
                                  hintStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark? Colors.blueGrey: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 15.0),
                        blurRadius: 15.0,
                      ),
                    ],
                  ),
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 50,
                                child: Icon(
                                  Icons.subject,
                                  size: 28,
                                ),
                              )
                              
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: InkWell(
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 50,
                                child: Icon(
                                  Icons.timelapse,
                                  size: 28,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  widget._spendLimit.type.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_right),
                            ],
                          ),
                          onTap: _chooseType,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: RaisedButton(
                                    color: Theme.of(context).primaryColor,
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.save,
                                            size: 28,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Lưu',
                                            style: Theme.of(context)
                                                .textTheme
                                                .title,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onPressed: _submit,
                                  ),
                                )),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: RaisedButton(
                                  color: Theme.of(context).buttonColor,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.delete,
                                          size: 28,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Xóa',
                                          style:
                                              Theme.of(context).textTheme.title,
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: _delete,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
