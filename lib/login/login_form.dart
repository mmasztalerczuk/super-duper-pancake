import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:questlly/Widgets/FormCard.dart';
import 'package:http/http.dart' as http;
import 'package:questlly/mainpage/main_bloc.dart';
import 'package:questlly/mainpage/main_event.dart';
import 'login_bloc.dart';
import 'login_event.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _MyAppState();
}

class _MyAppState extends State<LoginForm> {
  bool _isSelected = false;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  FormCard formCard= FormCard();

  @override
  Widget build(BuildContext context) {

    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          username: formCard.usernameController.text,
          password: formCard.passwordController.text,
        ),
      );
    }

    _onRegisterButtonPressed() {
      BlocProvider.of<MainBloc>(context).add(
        RegisterButtonPressed(),
      );
    }

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Color(0xFF055e98),
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(180),
                  ),
                  formCard,
                  SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                  InkWell(
                    child: Container(
                      height: ScreenUtil.getInstance().setHeight(100),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xFF17ead9),
                            Color(0xFF6078ea)
                          ]),
                          borderRadius: BorderRadius.circular(6.0),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF6078ea).withOpacity(.3),
                                offset: Offset(0.0, 8.0),
                                blurRadius: 8.0)
                          ]),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
//                              onTap: () async {
//                                var url = 'http://396fae25.ngrok.io/api/v1/rest-auth/login/';
//                                var response = await http.post(url, body: {
//                                  "username": "mariusz",
//                                  "email": "",
//                                  "password": "magicuj1rok"
//                                });
//                                print('Response status: ${response.statusCode}');
//                                print('Response body: ${response.body}');
//
//                              },
                          onTap: _onLoginButtonPressed,
                          child: Center(
                            child: Text("SIGNIN",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 18,
                                    letterSpacing: 1.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "New User? ",
                        style: TextStyle(fontFamily: "Poppins-Medium"),
                      ),
                      InkWell(
                        onTap: _onRegisterButtonPressed,
                        child: Text("SignUp",
                            style: TextStyle(
                                color: Color(0xFF5d74e3),
                                fontFamily: "Poppins-Bold")),
                      )
                    ],
                  )
                ],
              ),
            ),
      )
    );
  }
}

//class _LoginFormState extends State<LoginForm> {
//  final _usernameController = TextEditingController();
//  final _passwordController = TextEditingController();
//
//  @override
//  Widget build(BuildContext context) {
//    _onLoginButtonPressed() {
//      BlocProvider.of<LoginBloc>(context).add(
//        LoginButtonPressed(
//          username: _usernameController.text,
//          password: _passwordController.text,
//        ),
//      );
//    }
//
//    return BlocListener<LoginBloc, LoginState>(
//      listener: (context, state) {
//        if (state is LoginFailure) {
//          Scaffold.of(context).showSnackBar(
//            SnackBar(
//              content: Text('${state.error}'),
//              backgroundColor: Colors.red,
//            ),
//          );
//        }
//      },
//      child: BlocBuilder<LoginBloc, LoginState>(
//        builder: (context, state) {
//          return Form(
//            child: Column(
//              children: [
//                TextFormField(
//                  decoration: InputDecoration(labelText: 'username'),
//                  controller: _usernameController,
//                ),
//                TextFormField(
//                  decoration: InputDecoration(labelText: 'password'),
//                  controller: _passwordController,
//                  obscureText: true,
//                ),
//                RaisedButton(
//                  onPressed:
//                  state is! LoginLoading ? _onLoginButtonPressed : null,
//                  child: Text('Login'),
//                ),
//                Container(
//                  child: state is LoginLoading
//                      ? CircularProgressIndicator()
//                      : null,
//                ),
//              ],
//            ),
//          );
//        },
//      ),
//    );
//  }
//}
