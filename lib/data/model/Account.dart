import 'package:flutter/material.dart';
import 'package:wallet_exe/enums/account_type.dart';
import '../dao/account_table.dart';

class Account {
  int id; // auto generate & unique

  String name;
  //int idAppAccount;
  int balance;
  AccountType type;
  IconData icon;
  String img;

  Account(
      name,
      //idAppAccount,
      balance,
      type,
      icon,
      img);

  Account.copyOf(Account copy) {
    id = copy.id;
    name = copy.name;
    balance = copy.balance;
    type = copy.type;
    icon = copy.icon;
    img = copy.img;
  }

  // getter
  Map<String, dynamic> toMap() {
    return {
      AccountTable().id: id,
      AccountTable().name: name,
      AccountTable().balance: balance,
      AccountTable().type: type.value,
      AccountTable().icon: 1, //TO DO:
      AccountTable().img: img,
    };
  }

  // setter
  Account.fromMap(Map<String, dynamic> map) {
    id = map[AccountTable().id];
    name = map[AccountTable().name];
    balance = map[AccountTable().balance];
    type = AccountType.valueOf(map[AccountTable().type]);
    icon = Icons.check_circle_outline;
    img = map[AccountTable().img];
  }
}
