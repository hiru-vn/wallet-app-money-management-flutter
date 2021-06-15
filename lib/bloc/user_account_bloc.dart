import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wallet_exe/bloc/base_bloc.dart';
import 'package:wallet_exe/data/dao/account_table.dart';
import 'package:wallet_exe/data/dao/user_account_table.dart';
import 'package:wallet_exe/data/model/User.dart';
import 'package:wallet_exe/data/model/UserAccount.dart';
import 'package:wallet_exe/data/model/strorage_key.dart';
import 'package:wallet_exe/data/repository/user_repository.dart';
import 'package:wallet_exe/event/base_event.dart';
import 'package:wallet_exe/event/user_account_event.dart';

class UserAccountBloc extends BaseBloc {
  UserAccountTable _userAccountTable = UserAccountTable();

  final UserRepository _userRepository = UserRepositoryImpl();

  final storage = new FlutterSecureStorage();

  StreamController<UserAccount> _streamUserAccount =
      StreamController<UserAccount>();

  StreamController<UserModel> _streamUserModel = StreamController<UserModel>();

  UserAccount _userAccount;
  UserModel _userModel;

  Stream<UserAccount> get userAccount => _streamUserAccount.stream;

  Stream<UserModel> get userModel => _streamUserModel.stream;

  _getUser(String email, String password) async {
    _userAccount = await _userAccountTable.getUser(email, password);
    if (_userAccount != null)
      await storage.write(
          key: KEY_CURRENT_USER, value: jsonEncode(_userAccount.toMap()));
    _streamUserAccount.sink.add(_userAccount);
  }

  _getCurrentUser() async {
    _userModel = _userRepository.getCurrentUser();
    _streamUserModel.sink.add(_userModel);
  }

  _createAccount(String name, String email, String password) async {
    var stateData = await _userRepository.createAccount(name, email, password);
    if (stateData.data != null) {
      _userModel = stateData.data;
      _streamUserModel.sink.add(_userModel);
    } else {
      errorStreamControler.sink.add(stateData.e);
    }
  }

  _getUserByEmailAndPassword(String email, String password) async {
    final stateData =
        await _userRepository.getUserByEmailAndPassword(email, password);
    if (stateData.data != null) {
      _userModel = stateData.data;
      _streamUserModel.sink.add(_userModel);
    } else {
      errorStreamControler.sink.add(stateData.e);
    }
  }

  _addAccount(UserAccount userAccount) async {
    userAccount.id = await _userAccountTable.insert(userAccount);
    _userAccount = userAccount.id == 0 ? null : userAccount;
    if (_userAccount != null) {
      await storage.write(
          key: KEY_CURRENT_USER, value: jsonEncode(_userAccount.toMap()));
      await AccountTable().initAccountData(_userAccount.id);
    }
    _streamUserAccount.sink.add(_userAccount);
  }

  _updateAccount(UserAccount userAccount) async {
    _userAccountTable.update(userAccount);
    _userAccount = userAccount;
    _streamUserAccount.sink.add(_userAccount);
  }

  _deleteCurrentUser() async {
    if (await _userRepository.deleteCurrentUser()) _userAccount = null;
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
      _getUserByEmailAndPassword(event.email, event.password);
    } else if (event is GetCurrentUserEvent) {
      _getCurrentUser();
    } else if (event is DeleteCurrentUserEvent) {
      _deleteCurrentUser();
    } else if (event is CreateUserEvent) {
      _createAccount(event.name, event.email, event.password);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamUserAccount.close();
    _streamUserModel.close();
    super.dispose();
  }
}
