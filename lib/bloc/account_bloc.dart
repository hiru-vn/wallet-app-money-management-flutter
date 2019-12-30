
import 'dart:async';

import 'package:wallet_exe/bloc/base_bloc.dart';
import 'package:wallet_exe/data/dao/account_table.dart';
import 'package:wallet_exe/data/model/Account.dart';
import 'package:wallet_exe/event/account_event.dart';
import 'package:wallet_exe/event/base_event.dart';

class AccountBloc extends BaseBloc {
  AccountTable _accountTable = AccountTable();

  StreamController<List<Account>> _accountListStreamController =
      StreamController<List<Account>>();

  Stream<List<Account>> get accountListStream => _accountListStreamController.stream;

  List<Account> _accountListData = List<Account>();

  List<Account> get accountListData => _accountListData;

  initData() async {
    if (_accountListData.length != 0) return;
    _accountListData = await _accountTable.getAllAccount();
    if (_accountListData == null) return;

    _accountListStreamController.sink.add(_accountListData);
  }
  
  _addAccount(Account account) async {
    _accountTable.insert(account);

    _accountListData.add(account);
    _accountListStreamController.sink.add(_accountListData);
  }

  _deleteAccount(Account account) async {
    _accountTable.deleteAccount(account);

    _accountListData.remove(account);
    _accountListStreamController.sink.add(_accountListData);
  }

  _updateAccount(Account account) async {
    _accountTable.updateAccount(account);

    int index =_accountListData.indexWhere((item) {return item.name == account.name;}); //warning
    _accountListData[index] = account;
    _accountListStreamController.sink.add(_accountListData);
  }

  void dispatchEvent(BaseEvent event) { 
    if (event is AddAccountEvent) {
      Account account = Account.copyOf(event.account);
      _addAccount(account);
    } else if (event is DeleteAccountEvent) {
      Account account = Account.copyOf(event.account);
      _deleteAccount(account);
    } else if (event is UpdateAccountEvent) {
      Account account = Account.copyOf(event.account);
      _updateAccount(account);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}