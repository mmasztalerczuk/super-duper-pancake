import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:questlly/authentication/authentication_bloc.dart';
import 'package:questlly/mainpage/main_state.dart';
import 'package:questlly/repositories/users/user_repository.dart';

import 'main_event.dart';


class MainBloc extends Bloc<MainEvent, MainState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  MainBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  MainState get initialState => MainInitial();

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is RegisterButtonPressed) {
      yield MainRegisterState();
    }
  }
}
