import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:questlly/common/common.dart';
import 'package:questlly/common/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final String apiUrl = DotEnv().env['API_URL'];

  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    var url = apiUrl + '/api-token-auth/';
    var responseJson;

    try {
      final response = await http.post(url,
          body: {"username": username, "email": "", "password": password});
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    persistToken(responseJson['token']);

    return responseJson['token'];
  }

  Future<String> register({
    @required String username,
    @required String password,
    @required String email,
  }) async {
    var url = DotEnv().env['API_URL'] + '/api/v1/rest-auth/registration/';

    var response = await http.post(url, body: {
      "username": username,
      "email": email,
      "password1": password,
      "password2": password
    });


    print(response.body);

    Map response_map = jsonDecode(response.body);
    persistToken(response_map['token']);

    return response_map['token'];
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    return;
  }

  Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token') ?? 0;
    return false;
    if (token != 0) {
      return true;
    }
    return false;
  }
}
