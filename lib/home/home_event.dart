import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class AnswerSelected extends HomeEvent {
  final String id;
  final String question_id;

  const AnswerSelected(
      this.id,
      this.question_id
      );

  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'AnswerSelected {}';
}


class Status extends HomeEvent {
  final String start_date;
  final int points;


  const Status(
      this.start_date,
      this.points
      );

  @override
  List<Object> get props => [];
}

class RoundFinish extends HomeEvent {
  final String question;
  final String question_id;
  final String user_answer;
  final Answer answer_1;
  final Answer answer_2;
  final Answer answer_3;
  final Answer answer_4;

  const RoundFinish(
      this.question,
      this.question_id,
      this.user_answer,
      this.answer_1,
      this.answer_2,
      this.answer_3,
      this.answer_4,
      );


  @override
  List<Object> get props => [];

  @override
  String toString() =>
      'RoundFinish {}';
}

class Answer {
  final String text;
  final String id;
  final bool correct;

  const Answer(
      this.text,
      this.id,
      {this.correct: false}
      );
}

class NewQuestion extends HomeEvent {
  final String question;
  final String question_id;
  final Answer answer_1;
  final Answer answer_2;
  final Answer answer_3;
  final Answer answer_4;

  const NewQuestion(
      this.question,
      this.question_id,
      this.answer_1,
      this.answer_2,
      this.answer_3,
      this.answer_4,
  );

  @override
  List<Object> get props => [];
}