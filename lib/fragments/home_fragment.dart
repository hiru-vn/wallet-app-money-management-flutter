import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallet_exe/data/dao/account_table.dart';
import 'package:wallet_exe/data/database_helper.dart';
import 'package:wallet_exe/data/model/Account.dart';
import 'package:wallet_exe/enums/account_type.dart';
import 'package:wallet_exe/widgets/card_balance.dart';
import '../bloc/account_bloc.dart';
import 'package:wallet_exe/widgets/card_maximum_spend.dart';
import 'package:wallet_exe/widgets/card_spend_chart.dart';

class HomeFragment extends StatefulWidget {
  HomeFragment({Key key}) : super(key: key);

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  // get total balance
  int getTotalBalance(List<Account> accounts) {
    int totalBalance = 0;
    for (Account account in accounts) {
      totalBalance += account.balance;
    }
    return totalBalance;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var bloc = Provider.of<AccountBloc>(context);
    bloc.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: Container(
                width: double.infinity,
                height: ScreenUtil.getInstance().setHeight(170),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: InkWell(
                      onTap: () async {
                        print('object');

                        Database db = DatabaseHelper.instance.database;

                        List<Map> result = await db.query('account');

                        result.forEach((row) => print(row));

                        print('object2');
                      },
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
                            '1.000.000 đ',
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
          ),
          Cardbalance(),
          SizedBox(
            height: 15,
          ),
          CardMaximunSpend(),
          SizedBox(
            height: 15,
          ),
          CardSpendChart(),
          SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}
