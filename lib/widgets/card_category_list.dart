import 'package:flutter/material.dart';
import 'package:wallet_exe/data/model/Category.dart';
import 'package:wallet_exe/widgets/item_category.dart';

class CardCategoryList extends StatelessWidget {
  final List<Category> _categories;
  final String _Title;

  const CardCategoryList(this._Title, this._categories);

  List<Widget> createListCategory() {
    List<Widget> list = [];
    list.add(Divider());
    for (int i = 0; i < _categories.length; i++) {
      list.add(ItemCategory(_categories[i]));
      list.add(Divider());
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.blueGrey
              : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0,
            ),
          ],
        ),
        child: _categories.length > 0
            ? ExpansionTile(
                Title: Text(_Title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey)),
                initiallyExpanded: true,
                children: createListCategory(),
              )
            : ExpansionTile(
                Title: Text(_Title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey)),
                initiallyExpanded: false,
              ));
  }
}
