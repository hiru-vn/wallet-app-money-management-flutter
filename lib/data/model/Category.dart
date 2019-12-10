import 'package:flutter/material.dart';

class Category {
  int id; // auto generate & unique

  final String name;
  final int idAppAccount;
  final IconData icon;
  final Color color;
  final int idTypeTransaction;

  Category({
    this.name,
    this.idAppAccount,
    this.icon,
    this.color,
    this.idTypeTransaction
  });

  // getter
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'idAppAccount': idAppAccount,
      'icon' : icon,
      'color':color,
      'idTypeTransaction':idTypeTransaction,
    };
  }
  // setter
  static Category fromMap(Map<String, dynamic> map) {
    return Category(
      name : map['name'],
      idAppAccount : map['idAppAccount'],
      icon : map['icon'],
      color : map['color'],
      idTypeTransaction : map['idTypeTransaction'],
    );
  }
}