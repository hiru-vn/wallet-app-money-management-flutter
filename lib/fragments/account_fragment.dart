import 'package:flutter/material.dart';
import 'package:wallet_exe/data/dao/account_table.dart';
import 'package:wallet_exe/utils/text_input_formater.dart';
import 'package:wallet_exe/widgets/card_list_account.dart';

class AccountFragment extends StatefulWidget {
  AccountFragment({Key key}) : super(key: key);

  @override
  _AccountFragmentState createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
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
            child: FutureBuilder(
                future: AccountTable().getTotalBalance(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error.toString());
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.hasData) {
                    return Text(
                      'Tổng: '+textToCurrency(snapshot.data.toString()) + 'đ',
                      style: Theme.of(context).textTheme.title,
                    );
                  }
                  return Container(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          SizedBox(
            height: 15,
          ),
          CardListAccount(),
        ],
      ),
    );
  }
}
