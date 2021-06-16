import 'package:wallet_exe/data/local/user_local_data_source.dart';
import 'package:wallet_exe/data/model/Account.dart';
import 'package:wallet_exe/data/model/User.dart';
import 'package:wallet_exe/data/remote/account_remote_data_source.dart';
import 'package:wallet_exe/data/repo/state_data.dart';

abstract class AccountRepository {
  Future<StateData> getAllAccount();

  Future<StateData> createAccount(Account account);

  Future<StateData> updateAccount(Account account);

  Future<StateData> deleteAccount(Account account);

  Future<StateData> getAllBalance();
}

class AccountRepositoryImpl implements AccountRepository {
  static final _instance = AccountRepositoryImpl._internal();
  final _userLocalDataSource = UserLocalDataSource();
  final _accountRemoteDataSource = AccountRemoteDataSource();

  factory AccountRepositoryImpl() {
    return _instance;
  }

  AccountRepositoryImpl._internal();

  @override
  Future<StateData> createAccount(Account account) async {
    var _userCurrent = getCurrentUser();
    return _userCurrent != null
        ? await _accountRemoteDataSource.addAccount(_userCurrent.id, account)
        : _errorLogin();
  }

  @override
  Future<StateData> getAllAccount() async {
    var _currentUser = getCurrentUser();
    return _currentUser != null
        ? await _accountRemoteDataSource.getAllAccount(_currentUser.id)
        : _errorLogin();
  }

  StateData _errorLogin() => StateData.error(Exception('User must login'));

  @override
  Future<StateData> deleteAccount(Account account) async {
    var _currentUser = getCurrentUser();
    return _currentUser != null
        ? await _accountRemoteDataSource.deleteAccount(_currentUser.id, account)
        : _errorLogin();
  }

  @override
  Future<StateData> updateAccount(Account account) async {
    var _currentUser = getCurrentUser();
    return _currentUser != null
        ? await _accountRemoteDataSource.updateAccount(_currentUser.id, account)
        : _errorLogin();
  }

  UserModel getCurrentUser() {
    return _userLocalDataSource.getUserCurrent();
  }

  @override
  Future<StateData> getAllBalance() async {
    var sum = 0;
    final stateData = await getAllAccount();
    if (stateData.e != null) return StateData.error(stateData.e);

    (stateData.data as List<Account>).forEach((item) {
      sum += item.balance;
    });
    return StateData.success(sum);
  }
}
