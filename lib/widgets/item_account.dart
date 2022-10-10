import 'package:flutter/material.dart';
import 'package:wallet_exe/bloc/account_bloc.dart';
import 'package:wallet_exe/data/model/Account.dart';
import 'package:wallet_exe/event/account_event.dart';
import 'package:wallet_exe/pages/main_page.dart';
import 'package:wallet_exe/pages/update_account_page.dart';
import 'package:wallet_exe/utils/text_input_formater.dart';

class ItemAccount extends StatefulWidget {
  final Account _account;

  const ItemAccount(this._account);

  @override
  State<ItemAccount> createState() => _ItemAccountState();
}

class _ItemAccountState extends State<ItemAccount> {
  @override
  Widget build(BuildContext context) {
    final bloc = AccountBloc();
    bloc.initData();
    // var bloc = Provider.of<AccountBloc>(context);
    // bloc.initData();

    _moreOption(int option) {
      if (option == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UpdateAccountPage(widget._account)),
        );
      } else if (option == 1) {
        setState(() {
          bloc.event.add(DeleteAccountEvent(widget._account));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(
                index: 2,
              ),
            ),
          );
        });
      }
    }

    Widget _simplePopup() => PopupMenuButton<int>(
          onSelected: _moreOption,
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 0,
              child: Center(
                child: Text("Sửa"),
              ),
            ),
            PopupMenuItem(
              value: 1,
              child: Center(
                child: Text("Xóa"),
              ),
            ),
          ],
        );

    return
        // Consumer<AccountBloc>(
        //   builder: (context, bloc, child) =>
        StreamBuilder<List<Account>>(
      stream: bloc.accountListStream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
            return Container(
                child: ListTile(
              leading: Padding(
                padding: EdgeInsets.all(5),
                child: Image.asset(this.widget._account.img),
              ),
              title: Text(this.widget._account.name,
                  style: Theme.of(context).textTheme.subtitle1),
              subtitle:
                  Text(textToCurrency(this.widget._account.balance.toString())),
              trailing: _simplePopup(),
            ));
          default:
            return Center(
              child: Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            );
        }
      },
      // ),
    );
  }
}
