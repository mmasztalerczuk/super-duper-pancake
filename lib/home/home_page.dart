import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questlly/authentication/authentication_bloc.dart';
import 'package:questlly/repositories/users/user_repository.dart';
import 'package:web_socket_channel/io.dart';

import 'home_bloc.dart';
import 'home_form.dart';



class HomePage extends StatelessWidget {
  final UserRepository userRepository;

  HomePage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        builder: (context) {
          return HomeBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository
          );
        },
        child: HomeForm(),
      ),
    );
  }
}
