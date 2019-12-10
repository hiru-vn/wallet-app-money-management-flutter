import 'package:flutter/material.dart';

class TransactionType {
  int id; // auto generate & unique

  String name;
  Color color;

  TransactionType({
    this.name,
    this.color
  });

  // getter
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'color': color,
    };
  }
  // setter
  static TransactionType fromMap(Map<String, dynamic> map) {
    return TransactionType(
      name: map['name'],
      color: map['color'],
    );
  }
}