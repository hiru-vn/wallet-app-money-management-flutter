import 'package:flutter/material.dart';
import '../dao/user_account_table.dart';

class UserAccount {
  int id; // auto generate & unique

  String name;
  String mail;
  String password;
  int balance = 0;
  Color themeColor = Colors.amber;

  UserAccount({
    this.id,
    this.name,
    this.mail,
    this.password,
    this.balance,
    this.themeColor
  });

  // getter
  Map<String, dynamic> toMap() {
    return {
      UserAccountTable().id: id,
      UserAccountTable().name: name,
      UserAccountTable().mail: mail,
      UserAccountTable().password: password,
      UserAccountTable().balance: balance,
      UserAccountTable().themeColor: themeColor,
    };
  }
  // setter
  UserAccount.fromMap(Map<String, dynamic> map) {
    id = map[UserAccountTable().id];
    name = map[UserAccount().name];
    mail = map[UserAccount().mail];
    password = map[UserAccount().password];
    balance = map[UserAccount().balance];
    themeColor = map[UserAccount().themeColor];
  }
}