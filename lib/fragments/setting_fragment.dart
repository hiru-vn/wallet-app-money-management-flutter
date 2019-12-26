import 'package:flutter/material.dart';

class SettingFragment extends StatefulWidget {
  SettingFragment({Key key}) : super(key: key);

  @override
  _SettingFragmentState createState() => _SettingFragmentState();
}

class _SettingFragmentState extends State<SettingFragment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        color: Colors.white24,
        child: Text(
          'Settings',
          style: Theme.of(context).textTheme.display1,
        ),
      ),
    );
  }
}
