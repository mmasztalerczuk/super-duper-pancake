import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questlly/authentication/authentication_bloc.dart';
import 'package:questlly/login/login_page.dart';
import 'package:questlly/mainpage/main_event.dart';
import 'package:questlly/register/register_page.dart';
import 'package:questlly/repositories/users/user_repository.dart';

import 'main_bloc.dart';
import 'main_state.dart';

class MainForm extends StatelessWidget {
  final UserRepository userRepository;

  MainForm({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          print("mariusz");
          print(state);
          if (state is MainRegisterState) {
            print("Register button pressed");
            return RegisterPage(
              userRepository: userRepository,
            );
          }
          return LoginPage(userRepository: userRepository);
        },
      ),
    );
  }
}