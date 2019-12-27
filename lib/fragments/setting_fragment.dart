import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_exe/themes/theme.dart';
import 'package:wallet_exe/themes/theme_bloc.dart';

class SettingFragment extends StatefulWidget {
  SettingFragment();

  @override
  _SettingFragmentState createState() => _SettingFragmentState();
}

class _SettingFragmentState extends State<SettingFragment> {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<ThemeBloc>(context);

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(24.0),
        child: StreamBuilder(
            stream: _bloc.outTheme,
            builder: (context, AsyncSnapshot<AppTheme> snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Thiết đặt màu sắc:',
                        style: Theme.of(context).textTheme.subhead,
                      ),
                      SizedBox(width: 15,),
                      DropdownButton<AppTheme>(
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
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }
}
