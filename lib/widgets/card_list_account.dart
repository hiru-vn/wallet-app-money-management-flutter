import 'package:flutter/material.dart';
import 'package:wallet_exe/bloc/account_bloc.dart';
import 'package:wallet_exe/data/dao/account_table.dart';
import 'package:wallet_exe/data/model/Account.dart';
import 'package:wallet_exe/enums/account_type.dart';
import 'package:wallet_exe/widgets/item_account.dart';

class CardListAccount extends StatefulWidget {
  CardListAccount({Key key}) : super(key: key);

  @override
  _CardListAccountState createState() => _CardListAccountState();
}

class _CardListAccountState extends State<CardListAccount> {
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   var bloc = Provider.of<AccountBloc>(context);
  //   bloc.initData();
  // }

  _createListAccountTile(List<Account> listAccount) {
    List<Widget> list = new List<Widget>();
    for (int i=0; i< listAccount.length; i++) {
      list.add(ItemAccount(listAccount[i]));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    AccountBloc bloc = AccountBloc();
    bloc.initData();

    return 
    // Consumer<AccountBloc>(
    //   builder: (context, bloc, child) => 
      StreamBuilder<List<Account>>(
          stream: bloc.accountListStream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: Container(
                    width: 100,
                    height: 50,
                    child: Text('Bạn chưa tạo tài khoản nào'),
                  ),
                );
              case ConnectionState.none:

<<<<<<< HEAD
<<<<<<< HEAD
                case ConnectionState.active:
                  return Container(
                    width: double.infinity,
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
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: ExpansionTile(
                            Title: Text(
                              "Đang sử dụng (" +
                                  AccountTable.getTotalByType(
                                      snapshot.data, AccountType.SAVING) +
                                  " đ)",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            initiallyExpanded: true,
                            children: _createListAccountTile(snapshot.data
                                .where((item) =>
                                    (item.type == AccountType.SPENDING))
                                .toList()),
=======
=======
>>>>>>> parent of 4e15e8e (update new version)
              case ConnectionState.active:
                return Container(
                  width: double.infinity,
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
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: ExpansionTile(
                          title: Text(
                            "Đang sử dụng ("+ AccountTable.getTotalByType(snapshot.data, AccountType.SAVING) +" đ)",
                            style: Theme.of(context).textTheme.subhead,
<<<<<<< HEAD
>>>>>>> parent of 4e15e8e (update new version)
=======
>>>>>>> parent of 4e15e8e (update new version)
                          ),
                          initiallyExpanded: true,
                          children: _createListAccountTile(snapshot.data.where((item) => (item.type == AccountType.SPENDING)).toList()),
                        ),
<<<<<<< HEAD
<<<<<<< HEAD
                        Container(
                          width: double.infinity,
                          child: ExpansionTile(
                            Title: Text(
                              "Tài khoản tiết kiệm (" +
                                  AccountTable.getTotalByType(
                                      snapshot.data, AccountType.SAVING) +
                                  " đ)",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            initiallyExpanded: false,
                            children: _createListAccountTile(snapshot.data
                                .where(
                                    (item) => (item.type == AccountType.SAVING))
                                .toList()),
=======
=======
>>>>>>> parent of 4e15e8e (update new version)
                      ),
                      Container(
                        width: double.infinity,
                        child: ExpansionTile(
                          title: Text(
                            "Tài khoản tiết kiệm ("+ AccountTable.getTotalByType(snapshot.data, AccountType.SAVING) +" đ)",
                            style: Theme.of(context).textTheme.subhead,
<<<<<<< HEAD
>>>>>>> parent of 4e15e8e (update new version)
=======
>>>>>>> parent of 4e15e8e (update new version)
                          ),
                          initiallyExpanded: false,
                          children: _createListAccountTile(snapshot.data.where((item) => (item.type == AccountType.SAVING)).toList()),
                        ),
                      )
                    ],
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
    //       ,
    // );
  }
}
