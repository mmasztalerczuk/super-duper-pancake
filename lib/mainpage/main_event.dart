import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}

class RegisterButtonPressed extends MainEvent {

  @override
  List<Object> get props => [];
}



class MainBasicEvent extends MainEvent {
  const MainBasicEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'MainBasicEvent {}';
}
