import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallet_exe/bloc/user_account_bloc.dart';
import 'package:wallet_exe/event/user_account_event.dart';

class SplashFragment extends StatefulWidget {
  const SplashFragment({Key key}) : super(key: key);

  @override
  _SplashFragmentState createState() => _SplashFragmentState();
}

class _SplashFragmentState extends State<SplashFragment> {
  final _bloc = UserAccountBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.event.add(GetCurrentUserEvent());
    _bloc.userModel.listen((user) {
      Navigator.pushReplacementNamed(
          context, user != null ? '/home' : '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: EdgeInsets.only(top: 24),
        width: size.width,
        height: size.height,
        color: Colors.teal.shade200,
        alignment: Alignment.bottomCenter,
        child: Container(
          width: size.width,
          height: size.height * 0.8,
          padding: EdgeInsets.only(left: 24, right: 24),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(60),
                topLeft: Radius.circular(60),
              )),
        ),
      ),
    );
  }
}
