import 'package:flutter/material.dart';
import 'package:wallet_exe/fragments/register_fragment.dart';
import 'package:wallet_exe/pages/main_page.dart';

class LoginFragment extends StatefulWidget {
  const LoginFragment({Key key}) : super(key: key);

  @override
  _LoginFragmentState createState() => _LoginFragmentState();
}

class _LoginFragmentState extends State<LoginFragment> {
  void _submit() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }
  
  void _navRegister(){
    Navigator.push(context,MaterialPageRoute(builder: (context)=> RegisterFragment()));
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
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Email'),
              ),
              SizedBox(
                height: 32,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Password'),
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
