import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_exe/bloc/transaction_bloc.dart';
import 'package:wallet_exe/data/model/Account.dart';
import 'package:wallet_exe/data/model/Category.dart';
import 'package:wallet_exe/data/model/Transaction.dart';
import 'package:wallet_exe/event/transaction_event.dart';
import 'package:wallet_exe/pages/account_page.dart';
import 'package:wallet_exe/pages/category_page.dart';
import 'package:wallet_exe/utils/text_input_formater.dart';

class NewTransactionPage extends StatefulWidget {
  NewTransactionPage({Key key}) : super(key: key);

  @override
  _NewTransactionPageState createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends State<NewTransactionPage> {
  var _balanceController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _formBalanceKey = GlobalKey<FormState>();
  Category _category;
  Account _account;

  @override
  void initState() { 
    super.initState();
    
  }

  _getCurrentDate() {
      DateTime now = DateTime.now();
      String wd =
          now.weekday == 7 ? "Chủ Nhật" : "Thứ " + (now.weekday + 1).toString();
      String date = now.day.toString() +
          "/" +
          now.month.toString() +
          "/" +
          now.year.toString();
      return wd + " - " + date;
    }

    _getCurrentTime() {
      DateTime now = DateTime.now();
      return now.hour.toString() + ":" + now.minute.toString();
    }

  @override
  Widget build(BuildContext context) {
    var _bloc = TransactionBloc();
    _bloc.initData();

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 1080, height: 1920, allowFontScaling: true);

    void _submit() {
      if (!this._formBalanceKey.currentState.validate()) {
        return;
      }
      
      Transaction transaction = Transaction(this._account,this._category,currencyToInt(this._balanceController.text), DateTime.now() ,this._descriptionController.text);
      _bloc.event.add(AddTransactionEvent(transaction));

      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Giao dịch mới'),
      ),
      body: SingleChildScrollView(
          child: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
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
                    'Số tiền',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Form(
                          key: _formBalanceKey,
                          child: TextFormField(
                          validator: (String value) {
                            if (value.trim()=="") return 'Số tiền phải lớn hơn 0';
                            return currencyToInt(value) <= 0
                                ? 'Số tiền phải lớn hơn 0'
                                : null;
                          },
                          controller: _balanceController,
                          textAlign: TextAlign.end,
                          inputFormatters: [CurrencyTextFormatter()],
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 32,
                              fontWeight: FontWeight.w900),
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          autofocus: true,
                          decoration: InputDecoration(
                            suffixText: 'đ',
                            suffixStyle: Theme.of(context).textTheme.headline,
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
                        ),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
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
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () async {
                        _category = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryPage()),
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 50,
                            child: Icon(
                              Icons.category,
                              size: 28,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              _category==null? 'Chọn hạng mục':_category.name,
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  ),
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
                          ),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: this._descriptionController,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'Diễn giải',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          child: Icon(
                            Icons.calendar_today,
                            size: 28,
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                _getCurrentDate(),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            )),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            _getCurrentTime(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () async {
                        _account = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccountPage()),
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 50,
                            child: Icon(
                              Icons.account_balance,
                              size: 28,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              _account==null?'Chọn tài khoản':_account.name,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.save,
                        size: 28,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Ghi',
                        style: Theme.of(context).textTheme.title,
                      ),
                    ],
                  ),
                ),
                onPressed: _submit,
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      )),
    );
  }
}