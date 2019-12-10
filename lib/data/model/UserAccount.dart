import 'package:flutter/material.dart';

class UserAccount {
  int id; // auto generate & unique

  String name;
  String mail;
  String password;
  int balance = 0;
  Color themeColor = Colors.amber;

  UserAccount({
    this.name,
    this.mail,
    this.password,
    this.balance,
    this.themeColor
  });

  // getter
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mail': mail,
      'password': password,
      'balance' : balance,
      'themeColor' : themeColor,
    };
  }
  // setter
  static UserAccount fromMap(Map<String, dynamic> map) {
    return UserAccount(
      name: map['name'],
      mail: map['mail'],
      password: map['password'],
      balance: map['balance'],
      themeColor: map['themColor'],
    );
  }
}