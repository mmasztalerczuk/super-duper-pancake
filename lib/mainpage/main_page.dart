import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questlly/authentication/authentication_bloc.dart';
import 'package:questlly/login/login_page.dart';
import 'package:questlly/register/register_page.dart';
import 'package:questlly/repositories/users/user_repository.dart';

import 'main_bloc.dart';
import 'main_form.dart';
import 'main_state.dart';


class MainPage extends StatelessWidget {
  final UserRepository userRepository;

  MainPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: BlocProvider(
        builder: (context) {
          return MainBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              userRepository: userRepository
          );
        },
        child: MainForm(userRepository: userRepository),
      ),
    );
  }
}
