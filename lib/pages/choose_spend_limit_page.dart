import 'package:flutter/material.dart';
import 'package:wallet_exe/data/model/SpendLimit.dart';
import 'package:wallet_exe/bloc/spend_limit_bloc.dart';

class ChooseSpendLimitPage extends StatefulWidget {
  final int _currentIndex;
  const ChooseSpendLimitPage(this._currentIndex);

  @override
  _ChooseSpendLimitPageState createState() => _ChooseSpendLimitPageState();
}

class _ChooseSpendLimitPageState extends State<ChooseSpendLimitPage> {

  _submit(BuildContext context, int newIndex) {
    Navigator.pop(context, newIndex);
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   var bloc = Provider.of<SpendLimitBloc>(context);
  // }

  @override
  Widget build(BuildContext context) {
    var bloc = SpendLimitBloc();
    bloc.initData();

    _createList(List<SpendLimit> items) {
      List<Widget> list = List<Widget>();
      for (int i = 0; i < items.length; i++) {
        list.add(ListTile(
          onTap: () => _submit(context, i),
          leading: Icon(Icons.timelapse),
          title: Text(items[i].type.name),
          trailing: i == widget._currentIndex
              ? Icon(Icons.check_circle)
              : null,
        ));
        if (i != items.length - 1) {
          list.add(Divider());
        }
      }
      return list;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Chọn hạn mức'),
          centerTitle: true,
        ),
        body: StreamBuilder<List<SpendLimit>>(
            stream: bloc.spendLimitListStream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                  return SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: _createList(snapshot.data),
                          ),
                        ],
                      ),
                    ),
                  );
                case ConnectionState.waiting:
                  return Center(
                    child: Container(
                      width: 100,
                      height: 50,
                      child: Text('Empty list'),
                    ),
                  );
                case ConnectionState.none:
                default:
                  return Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  );
              }
            }));
  }
}
