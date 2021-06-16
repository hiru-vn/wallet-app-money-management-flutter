import 'package:wallet_exe/data/model/Account.dart';
import 'package:wallet_exe/data/remote/firebase_util.dart';
import 'package:wallet_exe/data/repo/constrant_document.dart';
import 'package:wallet_exe/data/repo/state_data.dart';

class AccountRemoteDataSource {
  static final _instance = AccountRemoteDataSource._internal();

  factory AccountRemoteDataSource() {
    return _instance;
  }

  AccountRemoteDataSource._internal();

  Future<StateData> getAllAccount(String userId) async {
    try {
      final querySnapshot = await fireStore
          .collection('$USER_COLLECTION/$userId/$WALLET_COLLECTION')
          .get();
      List<Account> accounts = List.generate(querySnapshot.docs.length,
          (index) => Account.fromMap(querySnapshot.docs[index].data()));
      return StateData.success(accounts);
    } catch (e) {
      return StateData.error(e);
    }
  }

  Future<StateData> addAccount(String userId, Account account) async {
    try {
      var documentReference = fireStore
          .collection('$USER_COLLECTION/$userId/$WALLET_COLLECTION')
          .doc();
      account.id = documentReference.id;
      await documentReference.set(account.toMap());
      return StateData.success(true);
    } catch (e) {
      return StateData.error(e);
    }
  }

  Future<StateData> updateAccount(String userId, Account account) async {
    try {
      await fireStore
          .collection('$USER_COLLECTION/$userId/$WALLET_COLLECTION')
          .doc(account.id)
          .update(account.toMap());
      return StateData.success(true);
    } catch (e) {
      StateData.error(e);
    }
  }

  Future<StateData> deleteAccount(String userId, Account account) async {
    try {
      await fireStore
          .collection('$USER_COLLECTION/$userId/$WALLET_COLLECTION')
          .doc(account.id)
          .delete();
      return StateData.success(true);
    } catch (e) {
      StateData.error(e);
    }
  }
}
