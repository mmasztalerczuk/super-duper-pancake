import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class MainInitial extends MainState {}

class MainRegisterState extends MainState {}

class MainLoginState extends MainState {}

class MainFailure extends MainState {
  final String error;

  const MainFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'MainFailure { error: $error }';
}
