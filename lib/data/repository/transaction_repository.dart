import 'package:wallet_exe/data/local/user_local_data_source.dart';
import 'package:wallet_exe/data/model/Transaction.dart';
import 'package:wallet_exe/data/model/User.dart';
import 'package:wallet_exe/data/remote/transaction_remote_data_source.dart';
import 'package:wallet_exe/data/repo/state_data.dart';
import 'package:wallet_exe/enums/transaction_type.dart';

abstract class TransactionRepository {
  Future<StateData> getAllTransaction();

  Future<StateData> getTransactionsByType(TransactionType transactionType);

  Future<StateData> addTransaction(Transaction transaction);

  Future<StateData> updateTransaction(Transaction transaction);

  Future<StateData> deleteTransaction(String transactionId);
}

class TransactionRepositoryIml implements TransactionRepository {
  static final _instance = TransactionRepositoryIml._internal();

  final _transactionRemoteDataSource = TransactionRemoteDataSource();
  final _userLocalDatSource = UserLocalDataSource();

  factory TransactionRepositoryIml() {
    return _instance;
  }

  TransactionRepositoryIml._internal();

  @override
  Future<StateData> addTransaction(Transaction transaction) async {
    return _getUser() != null
        ? await _transactionRemoteDataSource.addTransaction(
            _getUser().id, transaction)
        : _errorLogin();
  }

  @override
  Future<StateData> deleteTransaction(String transactionId) async {
    return _getUser() != null
        ? await _transactionRemoteDataSource.deleteTransaction(
            _getUser().id, transactionId)
        : _errorLogin();
  }

  @override
  Future<StateData> updateTransaction(Transaction transaction) async {
    return _getUser() != null
        ? await _transactionRemoteDataSource.editTransaction(
            _getUser().id, transaction)
        : _errorLogin();
  }

  @override
  Future<StateData> getAllTransaction() async {
    return _getUser() != null
        ? await _transactionRemoteDataSource.getAllTransaction(_getUser().id)
        : _errorLogin();
  }

  StateData _errorLogin() => StateData.error(Exception('User must login'));

  UserModel _getUser() => _userLocalDatSource.getUserCurrent();

  @override
  Future<StateData> getTransactionsByType(
      TransactionType transactionType) async {
    return _getUser() != null
        ? await _transactionRemoteDataSource.getTransactionsByType(
            _getUser().id, transactionType)
        : _errorLogin();
  }
}
