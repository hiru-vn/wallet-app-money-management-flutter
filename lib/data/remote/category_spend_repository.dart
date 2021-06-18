import 'package:wallet_exe/data/local/user_local_data_source.dart';
import 'package:wallet_exe/data/model/User.dart';
import 'package:wallet_exe/data/remote/transaction_remote_data_source.dart';
import 'package:wallet_exe/data/repo/state_data.dart';
import 'package:wallet_exe/enums/transaction_type.dart';

abstract class CategorySpendRepository {
  Future<StateData> getCategorySpendByTransactionType(TransactionType type);
}

class CategorySpendRepositoryImpl implements CategorySpendRepository {
  static final _instance = CategorySpendRepositoryImpl._internal();

  final _transactionRemoteDataSource = TransactionRemoteDataSource();
  final _userLocalDataSource = UserLocalDataSource();

  factory CategorySpendRepositoryImpl() {
    return _instance;
  }

  CategorySpendRepositoryImpl._internal();

  @override
  Future<StateData> getCategorySpendByTransactionType(
      TransactionType type) async {
    return _getUser() != null
        ? await _transactionRemoteDataSource.getTransactionsByType(
            _getUser().id, type)
        : _errorLogin();
  }

  StateData _errorLogin() => StateData.error(Exception('User must login'));

  UserModel _getUser() => _userLocalDataSource.getUserCurrent();
}
