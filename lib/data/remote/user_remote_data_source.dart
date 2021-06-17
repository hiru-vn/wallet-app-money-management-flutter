import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallet_exe/data/dao/category_table.dart';
import 'package:wallet_exe/data/model/Account.dart';
import 'package:wallet_exe/data/remote/account_remote_data_source.dart';
import 'package:wallet_exe/data/remote/firebase_util.dart';
import 'package:wallet_exe/data/repo/constrant_document.dart';
import 'package:wallet_exe/data/repo/state_data.dart';
import 'package:wallet_exe/data/model/User.dart';
import 'package:wallet_exe/enums/account_type.dart';

import 'category_remote_data_source.dart';

class UserRemoteDataSource {
  static final _instance = UserRemoteDataSource._internal();
  final _accountRemoteDataSource = AccountRemoteDataSource();

  factory UserRemoteDataSource() {
    return _instance;
  }

  UserRemoteDataSource._internal();

  Future<StateData> createUser(
    String name,
    String email,
    String password,
  ) async {
    final _categoryRemoteDataSource = CategoryRemoteDataSource();
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final user =
          UserModel(id: userCredential.user.uid, email: email, name: name);
      final userCollection = fireStore.collection(USER_COLLECTION).doc(user.id);
      await userCollection.set(user.toMap());
      await _accountRemoteDataSource.addAccount(
          userCollection.id,
          Account(
              name: "Ví",
              balance: 0,
              userId: userCollection.id,
              img: "assets/logo.png",
              type: AccountType.SPENDING));
      await _categoryRemoteDataSource.registerCategory(userCollection.id);
      return StateData.success(user);
    } catch (e) {
      return StateData.error(e);
    }
  }

  Future<StateData> getUserByEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final docSnapShot = await fireStore
          .collection(USER_COLLECTION)
          .doc(userCredential.user.uid)
          .get();
      return StateData.success(UserModel.fromMap(docSnapShot.data()));
    } catch (e) {
      return StateData.error(e);
    }
  }
}
