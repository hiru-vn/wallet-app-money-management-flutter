import 'package:flutter/material.dart';

class SettingFragment extends StatefulWidget {
  SettingFragment({Key key}) : super(key: key);

  @override
  _SettingFragmentState createState() => _SettingFragmentState();
}

class _SettingFragmentState extends State<SettingFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('setting'),
    );
  }
}