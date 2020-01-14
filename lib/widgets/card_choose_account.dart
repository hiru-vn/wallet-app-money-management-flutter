import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_exe/bloc/account_bloc.dart';
import 'package:wallet_exe/data/model/Account.dart';
import 'package:wallet_exe/enums/account_type.dart';
import 'package:wallet_exe/widgets/item_account_choose.dart';

class CardChooseAccount extends StatefulWidget {
  CardChooseAccount({Key key}) : super(key: key);

  @override
  _CardChooseAccountState createState() => _CardChooseAccountState();
}

class _CardChooseAccountState extends State<CardChooseAccount> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var bloc = Provider.of<AccountBloc>(context);
    bloc.initData();
  }

  final _createListAccountTile = (List<Account> listAccount) {
    List<Widget> list = new List<Widget>();
    for (int i=0; i< listAccount.length; i++) {
      list.add(ItemAccountChoose(listAccount[i]));
      list.add(Divider());
    }
    return list;
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountBloc>(
      builder: (context, bloc, child) => StreamBuilder<List<Account>>(
          stream: bloc.accountListStream,
          builder: (context, AsyncSnapshot snapshot) {
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
                            "Đang sử dụng",
                            style: Theme.of(context).textTheme.subhead,
                          ),
                          initiallyExpanded: true,
                          children: _createListAccountTile(snapshot.data.where((item) => (item.type == AccountType.SPENDING)).toList()),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: ExpansionTile(
                          title: Text(
                            "Tài khoản tiết kiệm",
                            style: Theme.of(context).textTheme.subhead,
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
          }),
    );
  }
}
