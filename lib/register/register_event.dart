import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterButtonPressed extends RegisterEvent {
  final String username;
  final String password;
  final String email;

  const RegisterButtonPressed({
    @required this.username,
    @required this.password,
    @required this.email,
  });

  @override
  List<Object> get props => [username, password];

  @override
  String toString() =>
      'RegisterButtonPressed { username: $username, password: $password }';
}
