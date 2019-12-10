import 'package:flutter/material.dart';

class Account {
  int id; // auto generate & unique

  final String name;
  final int idAppAccount;
  final int balance;
  final int type;
  final IconData icon;

  Account({
    this.name,
    this.idAppAccount,
    this.balance,
    this.type,
    this.icon
  });

  // getter
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'idAppAccount': idAppAccount,
      'balance' : balance,
      'type':type,
      'icon':icon,
    };
  }
  // setter
  static Account fromMap(Map<String, dynamic> map) {
    return Account(
      name : map['name'],
      idAppAccount : map['idAppAccount'],
      balance : map['balance'],
      type : map['type'],
      icon : map['icon'],
    );
  }
}