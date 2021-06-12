import 'package:flutter/material.dart';
import '../dao/user_account_table.dart';

class UserAccount {
  int id; // auto generate & unique
  String name;
  String email;
  String password;
  int balance = 0;
  Color themeColor = Colors.amber;

  UserAccount(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.balance,
      this.themeColor});

  static UserAccount copyOf(UserAccount userAccount) {
    return UserAccount(
      id: userAccount.id,
      name: userAccount.name,
      email: userAccount.email,
      password: userAccount.password,
    );
  }

  // getter
  Map<String, dynamic> toMap() {
    return {
      UserAccountTable().name: name,
      UserAccountTable().email: email,
      UserAccountTable().password: password,
    };
  }

  // setter
  UserAccount.fromMap(Map<String, dynamic> map) {
    id = map[UserAccountTable().id];
    name = map[UserAccount().name];
    email = map[UserAccount().email];
    password = map[UserAccount().password];
    balance = map[UserAccount().balance];
    themeColor = map[UserAccount().themeColor];
  }
}
