import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'home_event.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}


class StatusState extends HomeState {
  final String start_date;
  final int points;

  const StatusState(
      this.start_date,
      this.points,
      );
}


class HomeInitial extends HomeState {
  const HomeInitial();
}


class BasicQuestion extends HomeState {
  final String question;
  final String question_id;
  final Answer answer_1;
  final Answer answer_2;
  final Answer answer_3;
  final Answer answer_4;

  const BasicQuestion(
      this.question,
      this.question_id,
      this.answer_1,
      this.answer_2,
      this.answer_3,
      this.answer_4
      );
}


class RoundFinished extends BasicQuestion {
  final String user_answer;

  const RoundFinished(
      String question,
      String question_id,
      this.user_answer,
      Answer answer_1,
      Answer answer_2,
      Answer answer_3,
      Answer answer_4
      ): super(
      question,
      question_id,
      answer_1,
      answer_2,
      answer_3,
      answer_4
      );
}

class HomeQuestion extends BasicQuestion {
  const HomeQuestion(
      String question,
      String question_id,
      Answer answer_1,
      Answer answer_2,
      Answer answer_3,
      Answer answer_4
      ): super(
        question,
        question_id,
        answer_1,
        answer_2,
        answer_3,
        answer_4
      );
}


class HomeFailure extends HomeState {
  final String error;

  const HomeFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'HomeFailure { error: $error }';
}
