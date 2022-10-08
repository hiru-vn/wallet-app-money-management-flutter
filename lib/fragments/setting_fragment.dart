import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_exe/enums/currency.dart';
import 'package:wallet_exe/enums/language.dart';
import 'package:wallet_exe/themes/theme.dart';
import 'package:wallet_exe/themes/theme_bloc.dart';

class SettingFragment extends StatefulWidget {
  SettingFragment();

  @override
  _SettingFragmentState createState() => _SettingFragmentState();
}

class _SettingFragmentState extends State<SettingFragment> {
  Currency _currency = Currency.VIETNAM;
  Language _language = Language.VIETNAM;

  _submit() {}

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<ThemeBloc>(context);

    return SafeArea(
        child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                StreamBuilder(
                  stream: _bloc.outTheme,
                  builder: (context, AsyncSnapshot<AppTheme> snapshot) {
                    return ListTile(
                      title: Text('Thiết đặt màu sắc:'),
                      trailing: DropdownButton<AppTheme>(
                        hint: Text("Amber"),
                        value: snapshot.data,
                        items: myThemes.map((AppTheme appTheme) {
                          return DropdownMenuItem<AppTheme>(
                            value: appTheme,
                            child: Text(appTheme.name),
                          );
                        }).toList(),
                        onChanged: _bloc.inTheme,
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text('Đơn vị tiền tệ:'),
                  trailing: DropdownButton<Currency>(
                    //hint: Text(Currency.VIETNAM.name),
                    value: _currency,
                    onChanged: (value) {
                      setState(() {
                        _currency = value;
                      });
                    },
                    items: Currency.getAllType()
                        .map<DropdownMenuItem<Currency>>((Currency value) {
                      return DropdownMenuItem<Currency>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                  ),
                ),
                ListTile(
                  title: Text('Ngôn ngữ:'),
                  trailing: DropdownButton<Language>(
                    //hint: Text(Currency.VIETNAM.name),
                    value: _language,
                    onChanged: (value) {
                      setState(() {
                        _language = value;
                      });
                    },
                    items: Language.getAllType()
                        .map<DropdownMenuItem<Language>>((Language value) {
                      return DropdownMenuItem<Language>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 25,),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: RaisedButton.icon(
                          
                          color: Theme.of(context).primaryColor,
                          icon: Icon(Icons.cloud_upload),
                          label: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Đồng bộ dữ liệu',
                              style: Theme.of(context).textTheme.title,
                            ),
                          ),
                          onPressed: _submit,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: RaisedButton.icon(
                          color: Colors.redAccent,
                          icon: Icon(Icons.clear_all),
                          label: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Xóa toàn bộ dữ liệu',
                              style: Theme.of(context).textTheme.title,
                            ),
                          ),
                          onPressed: _submit,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }
}
