import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:wallet_exe/bloc/account_bloc.dart';
import 'package:wallet_exe/fragments/account_fragment.dart';
import 'package:wallet_exe/fragments/chart_fragment.dart';
import 'package:wallet_exe/fragments/home_fragment.dart';
import 'package:wallet_exe/fragments/setting_fragment.dart';
import 'package:wallet_exe/fragments/transaction_fragment.dart';
import 'package:wallet_exe/pages/add_account_page.dart';
import 'package:wallet_exe/pages/new_transaction_page.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class MainPage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Tổng quan", Icons.home),
    new DrawerItem("Các giao dịch", Icons.account_balance_wallet),
    new DrawerItem("Danh sách tài khoản", Icons.view_list),
    new DrawerItem("Biểu đồ", Icons.pie_chart),
    new DrawerItem("Cài đặt", Icons.settings),
  ];

  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return HomeFragment();
      case 1:
        return TransactionFragment();
      case 2:
        return AccountFragment();
      case 3:
        return ChartFragment();
      case 4:
        return SettingFragment();
      default:
        return Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  _actionAdd() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddAccountPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
      if (i == 3) drawerOptions.add(Divider());
    }

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 1080, height: 1920, allowFontScaling: true);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewTransactionPage()),
          );
        },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      appBar: AppBar(
          title: Text(widget.drawerItems[_selectedDrawerIndex].title),
          actions: _selectedDrawerIndex == 2
              ? <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _actionAdd,
                  )
                ]
              : null),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.brown,
                child: Text(
                  'H',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              accountName: Text('Nguyễn Quang Huy'),
              accountEmail: Text('quanghuy1998kh@gmail.com'),
            ),
            Column(children: drawerOptions)
          ],
        ),
      ),
      body: Provider<AccountBloc>.value(
        value: AccountBloc(),
        child: SingleChildScrollView(
          child: _getDrawerItemWidget(_selectedDrawerIndex),
        ),
      ),
    );
  }
}
