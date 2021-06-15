import 'package:wallet_exe/data/local/user_local_data_source.dart';
import 'package:wallet_exe/data/model/User.dart';
import 'package:wallet_exe/data/remote/user_remote_data_source.dart';
import 'package:wallet_exe/data/repo/state_data.dart';

abstract class UserRepository {
  Future<StateData> createAccount(String name, String email, String password);

  Future<StateData> getUserByEmailAndPassword(String email, String password);

  UserModel getCurrentUser();

  Future<bool> deleteCurrentUser();
}

class UserRepositoryImpl implements UserRepository {
  static final _instance = UserRepositoryImpl._internal();

  final UserRemoteDataSource _userRemoteDataSource = UserRemoteDataSource();
  final UserLocalDataSource _localDataSource = UserLocalDataSource();

  factory UserRepositoryImpl() {
    return _instance;
  }

  UserRepositoryImpl._internal();

  @override
  Future<StateData> createAccount(
    String name,
    String email,
    String password,
  ) async {
    var stateData =
        await _userRemoteDataSource.createUser(name, email, password);
    if (stateData.data != null)
      _localDataSource.saveUserCurrent(stateData.data);
    return stateData;
  }

  @override
  UserModel getCurrentUser() {
    return _localDataSource.getUserCurrent();
  }

  @override
  Future<StateData> getUserByEmailAndPassword(
      String email, String password) async {
    final stateData =
        await _userRemoteDataSource.getUserByEmailAndPassword(email, password);
    if (stateData.data != null) {
      await _localDataSource.saveUserCurrent(stateData.data);
    }
    return stateData;
  }

  @override
  Future<bool> deleteCurrentUser() async {
    return await _localDataSource.saveUserCurrent(null);
  }
}
