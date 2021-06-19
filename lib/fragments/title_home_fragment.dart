import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_exe/bloc/account_bloc.dart';
import 'package:wallet_exe/event/account_event.dart';
import 'package:wallet_exe/pages/balance_detail_page.dart';
import 'package:wallet_exe/utils/text_input_formater.dart';

class TitleHomeFragment extends StatefulWidget {
  TitleHomeFragment({Key key}) : super(key: key);

  @override
  _TitleHomeFragmentState createState() => _TitleHomeFragmentState();
}

class _TitleHomeFragmentState extends State<TitleHomeFragment> {
  final _accountBloc = AccountBloc();

  _balanceDetailNav() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BalanceDetailPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    _accountBloc.event.add(GetAllBalanceEvent());
    return StreamBuilder(
        stream: _accountBloc.balance,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              return Container(
                color: Theme.of(context).primaryColor,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Container(
                    width: double.infinity,
                    height: ScreenUtil.getInstance().setHeight(170),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.blueGrey
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: InkWell(
                          onTap: _balanceDetailNav,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Theme.of(context).accentColor,
                                child: Icon(
                                  Icons.attach_money,
                                  size: 30,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Text(
                                textToCurrency(snapshot.data.toString()),
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor),
                              ),
                              Icon(
                                Icons.navigate_next,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              );
            default:
              return Center(
                child: Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              );
          }
        });
  }
}
