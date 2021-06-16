import 'package:flutter/material.dart';
import 'package:wallet_exe/enums/account_type.dart';
import '../dao/account_table.dart';

class Account {
  String id; // auto generate & unique

  String name;
  String userId;

  //int idAppAccount;
  int balance;
  AccountType type;
  IconData icon;
  String img;

  Account(
      {this.name,
      //this.idAppAccount,
      this.balance,
      this.userId,
      this.type,
      this.icon,
      this.img});

  Account.copyOf(Account copy) {
    this.id = copy.id;
    this.name = copy.name;
    this.userId = copy.userId;
    this.balance = copy.balance;
    this.type = copy.type;
    this.icon = copy.icon;
    this.img = copy.img;
  }

  // getter
  Map<String, dynamic> toMap() {
    return {
      AccountTable().id: id,
      AccountTable().name: name,
      AccountTable().balance: balance,
      AccountTable().userId: userId,
      AccountTable().type: type.value,
      AccountTable().icon: 1, //TO DO:
      AccountTable().img: img,
    };
  }

  // setter
  Account.fromMap(Map<String, dynamic> map) {
    id = map[AccountTable().id];
    name = map[AccountTable().name];
    userId = map[AccountTable().userId];
    balance = map[AccountTable().balance];
    type = AccountType.valueOf(map[AccountTable().type]);
    icon = Icons.check_circle_outline;
    img = map[AccountTable().img];
  }
}
