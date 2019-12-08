import 'package:flutter/material.dart';
import 'package:wallet_exe/pages/new_transaction_page.dart';

class Category {
  final String name;
  final IconData icon;
  final int type;

  Category(this.name, this.type, {this.icon = Icons.category});
}

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
        );
      },
    );
  }
}
