import 'package:flutter/material.dart';
import 'package:wallet_exe/bloc/category_bloc.dart';
import 'package:wallet_exe/data/model/Category.dart';
import 'package:wallet_exe/event/category_event.dart';

class ItemCategory extends StatefulWidget {
  final Category _category;

  const ItemCategory(this._category);

  @override
  State<ItemCategory> createState() => _ItemCategoryState();
}

class _ItemCategoryState extends State<ItemCategory> {
  @override
  Widget build(BuildContext context) {
    final bloc = CategoryBloc();
    return Dismissible(
      key: Key(widget._category.id.toString()),
      onDismissed: (direction) {
        bloc.event.add(DeleteCategoryEvent(widget._category));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("đã xóa danh mục")));
      },
      direction: DismissDirection.endToStart,
      background: Container(
          color: Colors.red,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            Text("Xóa",
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            SizedBox(
              width: 20,
            ),
          ])),
      child: ListTile(
        leading: Icon(widget._category.icon),
        title: Text(widget._category.name),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Category category;
          setState(() {
            category = widget._category;
            Navigator.pop(
              context,
              category,
            );
          });
        },
      ),
    );
  }
}
