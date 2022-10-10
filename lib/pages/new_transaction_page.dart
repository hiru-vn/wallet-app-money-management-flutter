import 'package:flutter/material.dart';
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
import 'package:wallet_exe/pages/main_page.dart';
import 'package:wallet_exe/utils/text_input_formater.dart';

import '../bloc/category_bloc.dart';

class NewTransactionPage extends StatefulWidget {
  NewTransactionPage({Key key}) : super(key: key);

  @override
  _NewTransactionPageState createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends State<NewTransactionPage> {
  var _balanceController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _formBalanceKey = GlobalKey<FormState>();
  Category category;
  Account _account;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
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
    if (category == null) return Colors.red;
    return (category.transactionType == TransactionType.EXPENSE)
        ? Colors.red
        : Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    print(category ?? '');
    var _bloc = TransactionBloc();
    var _blocAccount = AccountBloc();
    var _categoryBloc = CategoryBloc();
    _categoryBloc.initData();
    _bloc.initData();
    _blocAccount.initData();

    void _submit() {
      if (!_formBalanceKey.currentState.validate()) {
        return;
      }
      if (_account == null) return;
      if (category == null) return;

      DateTime saveTime = DateTime(_selectedDate.year, _selectedDate.month,
          _selectedDate.day, _selectedTime.hour, _selectedTime.minute);
      Transaction transaction = Transaction(
          _account,
          category,
          currencyToInt(_balanceController.text),
          saveTime,
          _descriptionController.text);
      _bloc.event.add(AddTransactionEvent(transaction));

      if (category.transactionType == TransactionType.EXPENSE)
        _account.balance -= currencyToInt(_balanceController.text);
      if (category.transactionType == TransactionType.INCOME)
        _account.balance += currencyToInt(_balanceController.text);

      _blocAccount.event.add(UpdateAccountEvent(_account));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(
            index: 0,
          ),
        ),
      );
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
                    style: Theme.of(context).textTheme.titleMedium,
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
                              suffixStyle:
                                  Theme.of(context).textTheme.headline4,
                              prefix: Icon(
                                Icons.monetization_on,
                                color: Theme.of(context).colorScheme.secondary,
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
                        category = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryPage()),
                        );
                        setState(() {});
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 50,
                            child: Icon(
                              category == null ? Icons.category : category.icon,
                              size: 28,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              category == null
                                  ? 'Chọn hạng mục'
                                  : category.name,
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
                              controller: _descriptionController,
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
                        setState(() {});
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 50,
                            child: _account == null
                                ? Icon(
                                    Icons.account_balance_wallet,
                                    size: 28,
                                  )
                                : Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Image.asset(_account.img),
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
              child: TextButton(
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
                        style: Theme.of(context).textTheme.titleMedium.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
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
