import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallet_exe/bloc/user_account_bloc.dart';
import 'package:wallet_exe/event/user_account_event.dart';
import 'package:wallet_exe/fragments/register_fragment.dart';
import 'package:wallet_exe/pages/main_page.dart';
import 'package:wallet_exe/utils/validation_text.dart';

class LoginFragment extends StatefulWidget {
  const LoginFragment({Key key}) : super(key: key);

  @override
  _LoginFragmentState createState() => _LoginFragmentState();
}

class _LoginFragmentState extends State<LoginFragment> {
  final _bloc = UserAccountBloc();
  var hiddenPassword = true;
  var _showError = false;

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.userModel.listen((userAccount) {
      if (userAccount != null)
        _navHomePage();
    });
    _bloc.error.listen((error) {
      _isShowError(true);
    });
  }

  void _submit() {
    _isShowError(false);
    if (validateEmail(emailTextController.text.trim()) ==
        ValidateError.NULL) {
      if (validatePassword(passwordTextController.text.trim()) ==
          ValidateError.NULL) {
        _bloc.event.add(LoginEvent(
            emailTextController.text.trim().toLowerCase(),
            passwordTextController.text.trim()));
      } else
        _isShowError(true);
    } else
      _isShowError(true);
  }

  _isShowError(bool isShow) {
    setState(() {
      _showError = isShow;
    });
  }

  void _showPassword() {
    setState(() {
      hiddenPassword = false;
    });
  }

  void _hiddenPassword() {
    setState(() {
      hiddenPassword = true;
    });
  }

  Widget _showErrorWidget() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.red.shade500),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Text('Tài khoản hoặc mật khẩu không đúng'),
    );
  }

  void _navHomePage() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _navRegister() {
    Navigator.pushNamed(context, '/register');
  }

  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .primaryColor,
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              SizedBox(
                height: 42,
              ),
              _showError
                  ? _showErrorWidget()
                  : SizedBox(
                height: 0,
              ),
              SizedBox(
                height: _showError ? 42 : 0,
              ),
              TextField(
                controller: emailTextController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Email'),
              ),
              SizedBox(
                height: 32,
              ),
              TextField(
                controller: passwordTextController,
                obscureText: hiddenPassword,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        onTapDown: (tapDownDetails) {
                          _showPassword();
                        },
                        onTapUp: (tapUpDetails) {
                          _hiddenPassword();
                        },
                        onTapCancel: _hiddenPassword,
                        child: Icon(hiddenPassword
                            ? Icons.remove_red_eye_rounded
                            : Icons.remove_red_eye_outlined)),
                    border: OutlineInputBorder(),
                    hintText: 'Mật khẩu'),
              ),
              SizedBox(
                height: 32,
              ),
              TextButton(
                child: Container(
                    alignment: Alignment.center,
                    width: 120,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.amber.shade500,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Text(
                      'Đăng nhập',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                onPressed: _submit,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bạn có thể đăng ký ',
                  ),
                  GestureDetector(
                    onTap: _navRegister,
                    child: Text(
                      'tại đây',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
