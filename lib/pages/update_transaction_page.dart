import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_exe/bloc/account_bloc.dart';
import 'package:wallet_exe/bloc/transaction_bloc.dart';
import 'package:wallet_exe/data/model/Account.dart';
import 'package:wallet_exe/data/model/Category.dart';
import 'package:wallet_exe/data/model/Transaction.dart';
import 'package:wallet_exe/enums/transaction_type.dart';
import 'package:wallet_exe/event/account_event.dart';
import 'package:wallet_exe/event/transaction_event.dart';
import 'package:wallet_exe/pages/account_page.dart';
import 'package:wallet_exe/pages/category_page.dart';
import 'package:wallet_exe/utils/text_input_formater.dart';

class UpdateTransactionPage extends StatefulWidget {
  final Transaction _transaction;
  UpdateTransactionPage(this._transaction);

  @override
  _UpdateTransactionPageState createState() => _UpdateTransactionPageState();
}

class _UpdateTransactionPageState extends State<UpdateTransactionPage> {
  Transaction _transaction;
  var _balanceController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _formBalanceKey = GlobalKey<FormState>();
  Category _category;
  Account _account;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    _transaction = widget._transaction;
    _balanceController.text = textToCurrency(_transaction.amount.toString());
    _descriptionController.text = _transaction.description;
    _category = _transaction.category;
    _account = _transaction.account;

    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay time =
        await showTimePicker(context: context, initialTime: _selectedTime);
    if (time != null && time != _selectedTime) {
      setState(() {
        _selectedTime = time;
      });
    }
  }

  _getDate() {
    DateTime date = _selectedDate;
    String wd =
        date.weekday == 7 ? "Chủ Nhật" : "Thứ " + (date.weekday + 1).toString();
    String datePart = date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();
    return wd + " - " + datePart;
  }

  _getTime() {
    TimeOfDay time = _selectedTime;
    String formatTime = time.minute < 10 ? '0' : '';
    return time.hour.toString() + ":" + formatTime + time.minute.toString();
  }

  _getCurrencyColor() {
    if (this._category == null) return Colors.red;
    return (this._category.transactionType == TransactionType.EXPENSE)
        ? Colors.red
        : Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    var _bloc = TransactionBloc();
    var _blocAccount = AccountBloc();
    _bloc.initData();
    _blocAccount.initData();

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 1080, height: 1920, allowFontScaling: true);

    void _submit() {
      if (!this._formBalanceKey.currentState.validate()) {
        return;
      }
      if (_account == null) return;
      if (_category == null) return;

      DateTime saveTime = DateTime(_selectedDate.year, _selectedDate.month,
          _selectedDate.day, _selectedTime.hour, _selectedTime.minute);
      Transaction transaction = Transaction(
          this._account,
          this._category,
          currencyToInt(this._balanceController.text),
          saveTime,
          this._descriptionController.text);
      transaction.id = this._transaction.id;
      _bloc.event.add(UpdateTransactionEvent(transaction));

      if (this._category.transactionType == TransactionType.EXPENSE) {
        if (this._transaction.category.transactionType ==
            TransactionType.EXPENSE) {
          this._account.balance -=
              (currencyToInt(this._balanceController.text) -
                  this._transaction.amount);
        } else if (this._transaction.category.transactionType ==
            TransactionType.INCOME) {
          this._account.balance -=
              (currencyToInt(this._balanceController.text) +
                  this._transaction.amount);
        }
      }
      if (this._category.transactionType == TransactionType.INCOME) {
        if (this._transaction.category.transactionType ==
            TransactionType.EXPENSE) {
          this._account.balance +=
              (currencyToInt(this._balanceController.text) +
                  this._transaction.amount);
        } else if (this._transaction.category.transactionType ==
            TransactionType.INCOME)
             {
          this._account.balance +=
              (currencyToInt(this._balanceController.text) -
                  this._transaction.amount);
        }
      }

      _blocAccount.event.add(UpdateAccountEvent(this._account));

      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết giao dịch'),
      ),
      body: SingleChildScrollView(
          child: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.blueGrey
                    : Colors.white,
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
                              if (value.trim() == "")
                                return 'Số tiền phải lớn hơn 0';
                              return currencyToInt(value) <= 0
                                  ? 'Số tiền phải lớn hơn 0'
                                  : null;
                            },
                            controller: _balanceController,
                            textAlign: TextAlign.end,
                            inputFormatters: [CurrencyTextFormatter()],
                            style: TextStyle(
                                color: _getCurrencyColor(),
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
                          ),
                        ),
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
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.blueGrey
                    : Colors.white,
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
                              _category == null
                                  ? 'Chọn hạng mục'
                                  : _category.name,
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
                            onTap: () => _selectDate(context),
                            child: Text(
                              _getDate(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => _selectTime(context),
                          child: Text(
                            _getTime(),
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
                              _account == null
                                  ? 'Chọn tài khoản'
                                  : _account.name,
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
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: RaisedButton(
                        color: Theme.of(context).buttonColor,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                style: Theme.of(context).textTheme.title,
                              ),
                            ],
                          ),
                        ),
                        onPressed: _submit,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
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
                                'Lưu',
                                style: Theme.of(context).textTheme.title,
                              ),
                            ],
                          ),
                        ),
                        onPressed: _submit,
                      ),
                    ),
                  ),
                ],
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
