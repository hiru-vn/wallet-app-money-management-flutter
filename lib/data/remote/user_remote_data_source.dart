import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallet_exe/data/repo/constrant_document.dart';
import 'package:wallet_exe/data/repo/state_data.dart';
import 'package:wallet_exe/data/model/User.dart';

class UserRemoteDataSource {
  static final _instance = UserRemoteDataSource._internal();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  factory UserRemoteDataSource() {
    return _instance;
  }

  UserRemoteDataSource._internal();

  Future<StateData> createUser(
    String name,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final user =
          UserModel(id: userCredential.user.uid, email: email, name: name);
      await _store.collection(USER_DOCUMENT).doc(user.id).set(user.toMap());
      return StateData.success(user);
    } catch (e) {
      return StateData.error(e);
    }
  }

  Future<StateData> getUserByEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final docSnapShot = await _store
          .collection(USER_DOCUMENT)
          .doc(userCredential.user.uid)
          .get();
      return StateData.success(UserModel.fromMap(docSnapShot.data()));
    } catch (e) {
      return StateData.error(e);
    }
  }
}
