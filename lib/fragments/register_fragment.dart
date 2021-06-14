import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallet_exe/bloc/user_account_bloc.dart';
import 'package:wallet_exe/data/model/UserAccount.dart';
import 'package:wallet_exe/event/user_account_event.dart';
import 'package:wallet_exe/pages/main_page.dart';
import 'package:wallet_exe/utils/validation_text.dart';

class RegisterFragment extends StatefulWidget {
  const RegisterFragment({Key key}) : super(key: key);

  @override
  _RegisterFragmentState createState() => _RegisterFragmentState();
}

class _RegisterFragmentState extends State<RegisterFragment> {
  bool hiddenPassword = true;
  final _bloc = UserAccountBloc();
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  void _submit() {
    ValidateError validateError = ValidateError.NULL;
    if (nameTextController.text.trim().length <= 255 &&
        nameTextController.text.isNotEmpty) {
      final name = nameTextController.text.trim();
      validateError = validateEmail(emailTextController.text.trim());
      if (validateError == ValidateError.NULL) {
        final email = emailTextController.text.trim();
        validateError = validatePassword(passwordTextController.text.trim());
        if (validateError == ValidateError.NULL) {
          validateError = validateConfirmPassword(
              passwordTextController.text.trim(),
              confirmPasswordTextController.text.trim());
          if (validateError == ValidateError.NULL) {
            // Validate Complete
            final password = passwordTextController.text.trim();
            final userAccount = UserAccount(
                name: name, email: email.toLowerCase(), password: password);
            _bloc.event.add(AddUserEvent(userAccount));
            _navHomePage();
          }
        }
      }
    }
  }

  void _navHomePage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
        ModalRoute.withName('/home'));
  }

  void _navLogin() {
    Navigator.pop(context);
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _navLogin,
                child: Container(
                  margin: EdgeInsets.only(left: 8),
                  padding: EdgeInsets.all(8),
                  height: 60,
                  child: Icon(
                    Icons.keyboard_backspace_outlined,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: size.width,
                padding: EdgeInsets.only(left: 24, right: 24),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(60),
                      topLeft: Radius.circular(60),
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Đăng ký',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(color: Colors.red.shade200)),
                      child: Text(
                        '. Tên người dùng tối đa 255 ký tự\n\n. Email phải đúng định dạng abc@xyz.ab \n\n. Mật khẩu lớn hơn hoặc bằng 6 ký tự',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black54),
                      ),
                    ),
                    SizedBox(
                      height: 42,
                    ),
                    TextField(
                      controller: nameTextController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Tên người dùng'),
                    ),
                    SizedBox(
                      height: 32,
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
                    TextField(
                      controller: confirmPasswordTextController,
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
                          hintText: 'Xác thực mật khẩu'),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Text(
                            'Đăng Ký',
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
                          'Nếu bạn có tài khoản bấm ',
                        ),
                        GestureDetector(
                          onTap: _navLogin,
                          child: Text(
                            'tại đây',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ),
                        Text(
                          ' để đăng nhập',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    super.dispose();
  }
}
