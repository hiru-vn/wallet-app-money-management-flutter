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

  // Account({
  //   this.id,
  //   this.name,
  //   //this.idAppAccount,
  //   this.balance,
  //   this.type,
  //   this.icon
  // });
  Account(
      this.name,
      //this.idAppAccount,
      this.balance,
      this.type,
      this.icon);

  Account.copyOf(Account copy) {
    this.id = copy.id;
    this.name = copy.name;
    this.balance = copy.balance;
    this.type = copy.type;
    this.icon = copy.icon;
  }

  // getter
  Map<String, dynamic> toMap() {
    return {
      AccountTable().id: id,
      AccountTable().name: name,
      AccountTable().balance: balance,
      AccountTable().type: type.value,
      AccountTable().icon: 1, //TO DO:
    };
  }

  // setter
  Account.fromMap(Map<String, dynamic> map) {
    id = map[AccountTable().id];
    name = map[AccountTable().name];
    balance = map[AccountTable().balance];
    type = AccountType.valueOf(map[AccountTable().type]);
    icon = Icons.check_circle_outline;
  }
}
