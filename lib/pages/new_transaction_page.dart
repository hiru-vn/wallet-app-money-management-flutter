import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_exe/pages/account_page.dart';
import 'package:wallet_exe/pages/category_page.dart';
import 'package:wallet_exe/utils/text_input_formater.dart';

class NewTransactionPage extends StatefulWidget {
  NewTransactionPage({Key key}) : super(key: key);

  @override
  _NewTransactionPageState createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends State<NewTransactionPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 1080, height: 1920, allowFontScaling: true);

    _submit() {
      //save data
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
                        child: TextField(
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
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'đ',
                        style: Theme.of(context).textTheme.headline,
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
                      onTap: () {
                        Navigator.push(
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
                              'Chọn hạng mục',
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
                      onTap: () {
                        
                      },
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
                                'Thứ 6 - 14/11/2019',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            )),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            '12:48',
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
                      onTap: () {
                        Navigator.push(
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
                              'ATM',
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
