import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:questlly/authentication/authentication_bloc.dart';
import 'package:questlly/authentication/authentication_event.dart';
import 'package:questlly/repositories/users/user_repository.dart';

import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  RegisterBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterButtonPressed) {
      yield RegisterLoading();

      try {
        final token = await userRepository.register(
          username: event.username,
          email: event.email,
          password: event.password,
        );

        authenticationBloc.add(LoggedIn(token: token));

        yield RegisterInitial();
      } catch (error) {
        yield RegisterFailure(error: error.toString());
      }
    }
  }
}
