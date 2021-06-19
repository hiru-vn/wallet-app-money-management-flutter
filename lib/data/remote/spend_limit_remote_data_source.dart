import 'package:wallet_exe/data/model/SpendLimit.dart';
import 'package:wallet_exe/data/repo/constrant_document.dart';
import 'package:wallet_exe/data/repo/state_data.dart';
import 'firebase_util.dart';

class SpendLimitRemoteDataSource {
  static final _instance = SpendLimitRemoteDataSource._internal();

  factory SpendLimitRemoteDataSource() {
    return _instance;
  }

  SpendLimitRemoteDataSource._internal();

  Future<StateData> initDataWhenRegisterUser(String userId) async {
    final spendLimitMap = [
      {"amount": 1000000, "type": 0},
      {"amount": 4000000, "type": 1},
      {"amount": 12000000, "type": 2},
      {"amount": 48000000, "type": 3}
    ];
    final spendLimits = spendLimitMap.map((item) => SpendLimit.fromMap(item));
    final batch = fireStore.batch();
    try {
      for (var spendLimit in spendLimits) {
        final document = fireStore.collection(_getCollection(userId)).doc();
        spendLimit.id = document.id;
        batch.set(document, spendLimit.toMap());
      }
      await batch.commit();
      return StateData.success(true);
    } catch (e) {
      return StateData.error(e);
    }
  }

  Future<StateData> getAllSpendLimit(String userId) async {
    try {
      final querySnapShot = await fireStore.collection(_getCollection(userId))
          .get();
      return StateData.success(
          querySnapShot.docs.map((item) => SpendLimit.fromMap(item.data())).toList()
      );
    } catch (e) {
      return StateData.error(e);
    }
  }

  Future<StateData> updateSpendLimit(String userId,
      SpendLimit spendLimit) async {
    try {
      await fireStore
          .collection(_getCollection(userId))
          .doc(spendLimit.id)
          .update(spendLimit.toMap());
      return StateData.success(true);
    } catch (e) {
      return StateData.error(e);
    }
  }

  _getCollection(String userId) =>
      "$USER_COLLECTION/$userId/$SPEND_LIMIT_COLLECTION";
}
