import 'package:wallet_exe/data/dao/user_account_table.dart';

class UserModel {
  String id; // auto generate & unique
  String name;
  String email;

  UserModel({this.id, this.name, this.email});

  // getter
  Map<String, dynamic> toMap() {
    return {
      UserAccountTable().id: id,
      UserAccountTable().name: name,
      UserAccountTable().email: email,
    };
  }

  // setter
  UserModel.fromMap(Map<String, dynamic> map) {
    id = map[UserAccountTable().id];
    name = map[UserAccountTable().name];
    email = map[UserAccountTable().email];
  }
}
