import 'package:wallet_exe/data/local/user_local_data_source.dart';
import 'package:wallet_exe/data/model/Transaction.dart';
import 'package:wallet_exe/data/model/User.dart';
import 'package:wallet_exe/data/remote/transaction_remote_data_source.dart';
import 'package:wallet_exe/data/repo/state_data.dart';
import 'package:wallet_exe/enums/spend_limit_type.dart';
import 'package:wallet_exe/enums/transaction_type.dart';

abstract class TransactionRepository {
  Future<StateData> getAllTransaction();

  Future<StateData> getTransactionsByType(TransactionType transactionType);

  Future<StateData> addTransaction(Transaction transaction);

  Future<StateData> updateTransaction(Transaction transaction);

  Future<StateData> deleteTransaction(String transactionId);

  Future<StateData> getTransactionBySpendLimit(SpendLimitType spendLimitType);
}

class TransactionRepositoryIml implements TransactionRepository {
  static final _instance = TransactionRepositoryIml._internal();
  static const QUATERLY = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [10, 11, 12]
  ];

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

  @override
  Future<StateData> getTransactionBySpendLimit(
      SpendLimitType spendLimitType) async {
    final stateData = await getAllTransaction();
    if (stateData.data == null) return _errorLogin();
    int result = 0;
    final timeCurrent = DateTime.now();
    final transactions = stateData.data
        .where(
            (item) => item.category.transactionType == TransactionType.EXPENSE)
        .toList();
    switch (spendLimitType) {
      case SpendLimitType.WEEKLY:
        {
          var startDay =
              timeCurrent.subtract(Duration(days: timeCurrent.weekday));
          var endDay = startDay.add(Duration(days: 8));
          transactions
              .where((item) =>
                  (item.date.year == timeCurrent.year) &&
                  (item.date.month == timeCurrent.month) &&
                  item.date.isAfter(startDay) &&
                  item.date.isBefore(endDay))
              .toList()
              .forEach((element) {
            result += element.amount;
          });
          return StateData.success(result);
        }
      case SpendLimitType.MONTHLY:
        {
          transactions
              .where((item) =>
                  (item.date.year == timeCurrent.year) &&
                  item.date.month == timeCurrent.month)
              .toList()
              .forEach((item) {
            result += item.amount;
          });
          return StateData.success(result);
        }
      case SpendLimitType.QUATERLY:
        {
          QUATERLY.forEach((moths) {
            if (moths.contains(timeCurrent.month)) {
              transactions
                  .where((item) =>
                      (moths.contains(item.date.month)) &&
                      item.date.year == timeCurrent.year)
                  .toList()
                  .forEach((element) {
                result += element.amount;
              });
            }
          });
          return StateData.success(result);
        }
      case SpendLimitType.YEARLY:
        {
          transactions
              .where((item) => item.date.year == timeCurrent.year)
              .toList()
              .forEach((element) {
            result += element.amount;
          });
          return StateData.success(result);
        }
      default:
        return StateData.success(result);
    }
  }
}
