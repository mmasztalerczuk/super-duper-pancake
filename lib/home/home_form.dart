import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:questlly/home/widgets/home_form_card.dart';

import 'home_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeForm extends StatefulWidget {
  @override
  State<HomeForm> createState() => _MyAppState();
}

class _MyAppState extends State<HomeForm> {
  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  HomeFormCard formCard = HomeFormCard();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed(id, question_id) {
      BlocProvider.of<HomeBloc>(context).add(
        AnswerSelected(id, question_id),
      );
    }

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);


    return BlocBuilder<HomeBloc, HomeState>(
    builder: (context, state) {
      if (state is HomeInitial) {
        return new Scaffold(
          backgroundColor: Color(0xFF055e98),
          resizeToAvoidBottomPadding: true,
          body: Stack(
              fit: StackFit.expand,
              children: <Widget> [
                SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: ScreenUtil.getInstance().setHeight(240)),
                          Text('Następny Quiz:',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins-Bold",
                                fontSize: 18,
                                letterSpacing: 1.0),
                          ),
                          CircularProgressIndicator()
                        ],
                      )
                  ),
                ),
              ]
          ),
        );
      }
      print(state);
      if (state is StatusState) {
        return new Scaffold(
            backgroundColor: Color(0xFF055e98),
            resizeToAvoidBottomPadding: true,
            body: Stack(
                fit: StackFit.expand,
                children: <Widget> [
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: ScreenUtil.getInstance().setHeight(240)),
                          Text('Następny Quiz:',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins-Bold",
                              fontSize: 18,
                              letterSpacing: 1.0),
                          ),
                          Text("Dziś o" + state.start_date.replaceAll("2019-11-24T", " "),
                            style: TextStyle(
                                color: Colors.lightGreen,
                                fontFamily: "Poppins-Bold",
                                fontSize: 30,
                                letterSpacing: 1.0),
                          ),
                          SizedBox(height: ScreenUtil.getInstance().setHeight(240)),
                          Text("Punkty:  " + state.points.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins-Bold",
                                fontSize: 14,
                                letterSpacing: 1.0),
                          )
                        ],
                      )
                    ),
                  ),
                ]
            ),
        );
      }

      return new Scaffold(
        backgroundColor: Color(0xFF055e98),
        resizeToAvoidBottomPadding: true,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                    formCard,
                    SizedBox(height: ScreenUtil.getInstance().setHeight(140)),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        print(state);
                        var new_state = state as BasicQuestion;
                        print(new_state.answer_1);
                        Color tmp = Color(0xFF73a1c2);

                        if (state is RoundFinished) {
                          if (!state.answer_1.correct && state.user_answer == state.answer_1.id) {
                            tmp = Colors.red;
                          }

                          if (state.answer_1.correct) {
                            tmp = Color(0xFF33b249);
                          }
                        }
                        return InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: ScreenUtil.getInstance().setHeight(135),
                            decoration: BoxDecoration(
                                color: tmp,
                                borderRadius: BorderRadius.circular(6.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFF6078ea).withOpacity(.3),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => _onLoginButtonPressed(new_state.answer_1.id, new_state.question_id),
                                child: Center(
                                    child: Text(new_state.answer_1.text,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins-Bold",
                                            fontSize: 18,
                                            letterSpacing: 1.0))),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(50),
                    ),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        var new_state = state as BasicQuestion;
                        Color tmp = Color(0xFF73a1c2);

                        if (state is RoundFinished) {
                          if (!state.answer_2.correct && state.user_answer == state.answer_2.id) {
                            tmp = Colors.red;
                          }


                          if (state.answer_2.correct) {
                            tmp = Color(0xFF33b249);
                          }
                        }
                        return InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: ScreenUtil.getInstance().setHeight(130),
                            decoration: BoxDecoration(
                                color: tmp,
                                borderRadius: BorderRadius.circular(6.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFF6078ea).withOpacity(.3),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => _onLoginButtonPressed(new_state.answer_2.id, new_state.question_id),
                                child: Center(
                                    child: Text(new_state.answer_2.text,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins-Bold",
                                            fontSize: 18,
                                            letterSpacing: 1.0))),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(50),
                    ),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        var new_state = state as BasicQuestion;
                        Color tmp = Color(0xFF73a1c2);

                        if (state is RoundFinished) {
                          if (!state.answer_3.correct && state.user_answer == state.answer_3.id) {
                            tmp = Colors.red;
                          }


                          if (state.answer_3.correct) {
                            tmp = Color(0xFF33b249);
                          }
                        }
                        return InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: ScreenUtil.getInstance().setHeight(130),
                            decoration: BoxDecoration(
                                color: tmp,
                                borderRadius: BorderRadius.circular(6.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFF6078ea).withOpacity(.3),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => _onLoginButtonPressed(new_state.answer_3.id, new_state.question_id),
                                child: Center(
                                    child: Text(new_state.answer_3.text,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins-Bold",
                                            fontSize: 18,
                                            letterSpacing: 1.0))),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(50),
                    ),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        var new_state = state as BasicQuestion;
                        Color tmp = Color(0xFF73a1c2);

                        if (state is RoundFinished) {
                          if (!state.answer_4.correct && state.user_answer == state.answer_4.id) {
                            tmp = Colors.red;
                          }


                          if (state.answer_4.correct) {
                            tmp = Color(0xFF33b249);
                          }
                        }
                        return InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: ScreenUtil.getInstance().setHeight(130),
                            decoration: BoxDecoration(
                                color: tmp,
                                borderRadius: BorderRadius.circular(6.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFF6078ea).withOpacity(.3),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => _onLoginButtonPressed(new_state.answer_4.id, new_state.question_id),
                                child: Center(
                                    child: Text(new_state.answer_4.text,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins-Bold",
                                            fontSize: 18,
                                            letterSpacing: 1.0))),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );



    });

  }
}