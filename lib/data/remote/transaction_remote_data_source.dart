import 'package:wallet_exe/data/dao/account_table.dart';
import 'package:wallet_exe/data/dao/category_table.dart';
import 'package:wallet_exe/data/dao/transaction_table.dart';
import 'package:wallet_exe/data/model/Transaction.dart';
import 'package:wallet_exe/data/remote/firebase_util.dart';
import 'package:wallet_exe/data/repo/constrant_document.dart';
import 'package:wallet_exe/data/repo/state_data.dart';
import 'package:wallet_exe/enums/transaction_type.dart';
import 'package:wallet_exe/widgets/item_spend_chart_circle.dart';

class TransactionRemoteDataSource {
  static final _instance = TransactionRemoteDataSource._internal();

  factory TransactionRemoteDataSource() {
    return _instance;
  }

  TransactionRemoteDataSource._internal();

  Future<StateData> getAllTransaction(String userId) async {
    try {
      final transactions = <Transaction>[];
      final querySnapShot =
          await fireStore.collection(_getCollectionTransaction(userId)).get();

      for (var doc in querySnapShot.docs) {
        final categoryMap = await fireStore
            .collection(_getCollectionCategory(userId))
            .doc(doc[TransactionTable().idCategory])
            .get();
        final accountMap = await fireStore
            .collection(_getCollectionAccount(userId))
            .doc(doc[AccountTable().id])
            .get();
        final Map<String, dynamic> map = new Map();
        map.addAll(doc.data());
        map[CategoryTable().tableName] = categoryMap.data();
        map[AccountTable().tableName] = accountMap.data();
        transactions.add(Transaction.fromMap(map));
      }
      return StateData.success(transactions);
    } catch (e) {
      return StateData.error(e);
    }
  }

  Future<StateData> getTransactionsByType(
      String userId, TransactionType type) async {
    final stateData = await getAllTransaction(userId);
    if (stateData.data == null) return stateData;

    final categorySpends = (stateData.data as List<Transaction>)
        .where((transaction) => transaction.category.transactionType == type)
        .toList()
        .map((transaction) => CategorySpend(
            transaction.category.name, transaction.amount, transaction.date))
        .toList();
    return StateData.success(categorySpends);
  }

  Future<StateData> addTransaction(
      String userId, Transaction transaction) async {
    try {
      final doc = fireStore.collection(_getCollectionTransaction(userId)).doc();
      transaction.id = doc.id;
      await doc.set(transaction.toMap());
      return StateData.success(transaction);
    } catch (e) {
      return StateData.error(e);
    }
  }

  Future<StateData> editTransaction(
      String userId, Transaction transaction) async {
    try {
      await fireStore
          .collection(_getCollectionTransaction(userId))
          .doc(transaction.id)
          .update(transaction.toMap());
      return StateData.success(true);
    } catch (e) {
      return StateData.error(e);
    }
  }

  Future<StateData> deleteTransaction(
      String userId, String transactionId) async {
    try {
      await fireStore
          .collection(_getCollectionTransaction(userId))
          .doc(transactionId)
          .delete();
      return StateData.success(true);
    } catch (e) {
      return StateData.error(e);
    }
  }

  _getCollectionTransaction(String userId) =>
      '$USER_COLLECTION/$userId/$TRANSACTION_COLLECTION';

  _getCollectionCategory(String userId) =>
      '$USER_COLLECTION/$userId/$CATEGORY_COLLECTION';

  _getCollectionAccount(String userId) =>
      '$USER_COLLECTION/$userId/$WALLET_COLLECTION';
}
