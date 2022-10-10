import 'package:flutter/material.dart';
import 'package:wallet_exe/enums/transaction_type.dart';
import '../dao/category_table.dart';
import '../../utils/color_util.dart';

class Category {
  int id; // auto generate & unique

  String name;
  IconData icon;
  Color color;
  TransactionType transactionType;
  String description;

  Category(
    this.name,
    this.icon,
    this.color,
    this.transactionType,
    this.description,
  );

  Category.copyOf(Category copy) {
    this.id = copy.id;
    this.name = copy.name;
    this.icon = copy.icon;
    this.color = copy.color;
    this.transactionType = copy.transactionType;
    this.description = copy.description;
  }

  // getter
  Map<String, dynamic> toMap() {
    return {
      CategoryTable().id: id,
      CategoryTable().color: color.value,
      CategoryTable().name: name,
      CategoryTable().type: transactionType.value,
      CategoryTable().icon: icon.codePoint.toString(),
      CategoryTable().description : description,
    };
  }
  // setter
  Category.fromMap(Map<String, dynamic> map) {
    id = map[CategoryTable().id];
    name = map[CategoryTable().name];
    color = valueToColor(map[CategoryTable().color]);
    icon = IconData(map[CategoryTable().icon], fontFamily: 'MaterialIcons');
    transactionType = TransactionType.valueOf(map[CategoryTable().type]);
    description = map[CategoryTable().description];
  }
}