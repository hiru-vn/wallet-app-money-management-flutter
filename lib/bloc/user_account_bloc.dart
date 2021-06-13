import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wallet_exe/bloc/base_bloc.dart';
import 'package:wallet_exe/data/dao/user_account_table.dart';
import 'package:wallet_exe/data/model/UserAccount.dart';
import 'package:wallet_exe/event/base_event.dart';
import 'package:wallet_exe/event/user_account_event.dart';

class UserAccountBloc extends BaseBloc {
  static const KEY_CURRENT_USER = 'KEY_CURRENT_USER';
  UserAccountTable _userAccountTable = UserAccountTable();

  final storage = new FlutterSecureStorage();

  StreamController<UserAccount> _streamUserAccount =
      StreamController<UserAccount>();

  UserAccount _userAccount;

  Stream<UserAccount> get userAccount => _streamUserAccount.stream;

  _getUser(String email, String password) async {
    _userAccount = await _userAccountTable.getUser(email, password);
    if (_userAccount != null)
      storage.write(
          key: KEY_CURRENT_USER, value: jsonEncode(_userAccount.toMap()));
    _streamUserAccount.sink.add(_userAccount);
  }

  _getCurrentUser() async {
    var stringUser = await storage.read(key: KEY_CURRENT_USER);
    if (stringUser == null)
      _userAccount = null;
    else {
      Map<String, dynamic> map = jsonDecode(stringUser);
      _userAccount = UserAccount.fromMap(map);
    }
    _streamUserAccount.sink.add(_userAccount);
  }

  _addAccount(UserAccount userAccount) async {
    _userAccountTable.insert(userAccount);
    _userAccount = userAccount;
    if (_userAccount != null)
      storage.write(
          key: KEY_CURRENT_USER, value: jsonEncode(_userAccount.toMap()));
    _streamUserAccount.sink.add(_userAccount);
  }

  _updateAccount(UserAccount userAccount) async {
    _userAccountTable.update(userAccount);
    _userAccount = userAccount;
    _streamUserAccount.sink.add(_userAccount);
  }

  void dispatchEvent(BaseEvent event) {
    if (event is AddUserEvent) {
      UserAccount user = UserAccount.copyOf(event.userAccount);
      _addAccount(user);
    } else if (event is UpdateUserEvent) {
      UserAccount user = UserAccount.copyOf(event.userAccount);
      _updateAccount(user);
    } else if (event is LoginEvent) {
      _getUser(event.email, event.password);
    } else if (event is GetCurrentUserEvent) {
      _getCurrentUser();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamUserAccount.close();
    super.dispose();
  }
}
