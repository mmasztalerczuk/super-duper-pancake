import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home_bloc.dart';
import '../home_state.dart';

class HomeFormCard extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                print(state);
                var new_state = state as BasicQuestion;
                return Text(new_state.question,
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(30),
                        fontFamily: "Poppins-Bold",
                        letterSpacing: .6));
              },
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
          ],
        ),
      ),
    );
  }
}
