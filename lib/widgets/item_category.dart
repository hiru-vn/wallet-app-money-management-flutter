import 'package:flutter/material.dart';
import 'package:wallet_exe/data/model/Category.dart';

class ItemCategory extends StatelessWidget {
  final Category _category;

  const ItemCategory(this._category);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(_category.icon),
      title: Text(_category.name),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.pop(
          context,
          this._category,
        );
      },
    );
  }
}
