import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:questlly/authentication/authentication_bloc.dart';
import 'package:questlly/repositories/users/user_repository.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'home_event.dart';
import 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  WebSocketChannel channel;
  StreamSubscription channelSubscription;

  HomeBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  }) {
    assert(userRepository != null);
    assert(authenticationBloc != null);
    Map<String,dynamic> attributeMap = new Map<String,dynamic>();

    attributeMap["Token"] = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoibWFyaXVzei1kYXJ0In0.wgs5cNuPydceBl7XXo46vmwn_DxJZgF2bwLk4THGM2s';
    channel = IOWebSocketChannel.connect('wss://3c7e03ea.ngrok.io', headers: attributeMap);

    channelSubscription = channel.stream.listen((state) {
      Map valueMap = json.decode(state);
      print(state);
      switch(valueMap['type']) {
        case "status":
          {
              Status status = Status(valueMap['start_date'], valueMap['points']);
              add(status);

          }
        break;
        case "question":
          {
            NewQuestion new_question = NewQuestion(
              valueMap['text'],
              valueMap['question_id'],
              Answer(valueMap['answers'][0]['text'], valueMap['answers'][0]['id']),
              Answer(valueMap['answers'][1]['text'], valueMap['answers'][1]['id']),
              Answer(valueMap['answers'][2]['text'], valueMap['answers'][2]['id']),
              Answer(valueMap['answers'][3]['text'], valueMap['answers'][3]['id']),
            );

            add(new_question);

          }
        break;
        case "round_finish":
          {
            RoundFinish new_question = RoundFinish(
              valueMap['text'],
              valueMap['question_id'],
              valueMap['user_answer'],
              Answer(valueMap['answers'][0]['text'], valueMap['answers'][0]['id'], correct: valueMap['answers'][0]['correct']),
              Answer(valueMap['answers'][1]['text'], valueMap['answers'][1]['id'], correct: valueMap['answers'][1]['correct']),
              Answer(valueMap['answers'][2]['text'], valueMap['answers'][2]['id'], correct: valueMap['answers'][2]['correct']),
              Answer(valueMap['answers'][3]['text'], valueMap['answers'][3]['id'], correct: valueMap['answers'][3]['correct']),


            );

            add(new_question);

          }
          break;
      }
    });
    
    channel.sink.add('{"action": "join", "quiz": "123-456-789"}');

  }

  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is NewQuestion) {
      HomeQuestion home_initial = HomeQuestion(
          event.question,
          event.question_id,
          event.answer_1,
          event.answer_2,
          event.answer_3,
          event.answer_4,
      );
      yield home_initial;
    }
    if (event is RoundFinish) {
      yield RoundFinished(
        event.question,
        event.question_id,
        event.user_answer,
        event.answer_1,
        event.answer_2,
        event.answer_3,
        event.answer_4,
      );
    }
    if (event is AnswerSelected) {
      channel.sink.add('{"action": "answer", "quiz_id": "123-456-789", '
          '"question_id": ' + event.question_id + ', "answer_id": ' + event.id + '}');
    }
    if (event is Status) {
      yield StatusState(event.start_date, event.points);
    }
  }
}
