import 'package:wallet_exe/data/model/SpendLimit.dart';
import 'package:wallet_exe/data/model/User.dart';
import 'package:wallet_exe/data/remote/spend_limit_remote_data_source.dart';
import 'package:wallet_exe/data/repo/state_data.dart';
import 'package:wallet_exe/data/repository/user_repository.dart';

abstract class SpendLimitRepository {
  Future<StateData> getAllSpendLimit();

  Future<StateData> updateSpendLimit(SpendLimit spendLimit);
}

class SpendLimitRepositoryImpl implements SpendLimitRepository {
  static final _instance = SpendLimitRepositoryImpl._internal();

  final _spendLimitRemoteDataSource = SpendLimitRemoteDataSource();
  final UserRepository _userRepository = UserRepositoryImpl();

  factory SpendLimitRepositoryImpl() {
    return _instance;
  }

  SpendLimitRepositoryImpl._internal();

  @override
  Future<StateData> getAllSpendLimit()async {
    return _getUser() != null
        ? await _spendLimitRemoteDataSource.getAllSpendLimit(_getUser().id)
        : _errorLogin();
  }

  @override
  Future<StateData> updateSpendLimit(SpendLimit spendLimit) async{
    return _getUser() != null
        ? await _spendLimitRemoteDataSource.updateSpendLimit(_getUser().id,spendLimit)
        : _errorLogin();
  }

  StateData _errorLogin() {
    return StateData.error(Exception('User must login'));
  }

  UserModel _getUser() {
    return _userRepository.getCurrentUser();
  }
}
