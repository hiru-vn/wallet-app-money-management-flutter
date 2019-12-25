import 'package:flutter/material.dart';
import 'package:wallet_exe/enums/spend_limit_type.dart';

class SpendLimitTypePage extends StatelessWidget {
  SpendLimitType _type;

  SpendLimitTypePage(this._type);

  @override
  Widget build(BuildContext context) {
    _submit(SpendLimitType type) {
      Navigator.pop(context, type);
    }

    _createList() {
      List<Widget> list = List<Widget>();
      List<SpendLimitType> items = SpendLimitType.getAllType();
      for (int i = 0; i < items.length; i++) {
        list.add(ListTile(
          onTap: () => _submit(items[i]),
          leading: Icon(Icons.timelapse),
          title: Text(items[i].name),
          trailing: Icon(Icons.keyboard_arrow_right),
        ));
        if (i!=items.length-1) {
          list.add(Divider());
        }
      }
      return list;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Loại hạn mức'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: _createList(),
        ),
      ),
    );
  }
}
