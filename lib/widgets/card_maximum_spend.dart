import 'package:flutter/material.dart';
import 'package:wallet_exe/bloc/spend_limit_bloc.dart';
import 'package:wallet_exe/data/model/SpendLimit.dart';
import 'package:wallet_exe/pages/choose_spend_limit_page.dart';
import 'package:wallet_exe/widgets/item_maximum_spend.dart';

class CardMaximunSpend extends StatefulWidget {
  CardMaximunSpend({Key key}) : super(key: key);

  @override
  _CardMaximunSpendState createState() => _CardMaximunSpendState();
}

class _CardMaximunSpendState extends State<CardMaximunSpend> {
  int _currentIndex = 1;

  _chooseSpendLimit() async {
    int temp = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChooseSpendLimitPage(_currentIndex)),
    );

    // prevent null
    if (temp != null) _currentIndex = temp;
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

    return StreamBuilder<List<SpendLimit>>(
        stream: bloc.spendLimitListStream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Container(
                  width: 100,
                  height: 50,
                  child: Text('Bạn chưa tạo hạn mức nào'),
                ),
              );
            case ConnectionState.none:

            case ConnectionState.active:
              return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark? Colors.blueGrey: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 15.0),
                        blurRadius: 15.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Hạn mức chi',
                              style: Theme.of(context).textTheme.title),
                          IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: this._chooseSpendLimit,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MaximunSpendItem(snapshot.data[this._currentIndex]),
                    ],
                  ));
            default:
              return Center(
                child: Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              );
          }
        },
    );
  }
}
