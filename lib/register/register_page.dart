import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questlly/authentication/authentication_bloc.dart';
import 'package:questlly/mainpage/main_bloc.dart';
import 'package:questlly/repositories/users/user_repository.dart';

import 'register_bloc.dart';
import 'register_form.dart';


class RegisterPage extends StatelessWidget {
  final UserRepository userRepository;

  RegisterPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RegisterBloc>(
        builder: (context) {
          return RegisterBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: RegisterForm(),
      ),
    );
  }
}
