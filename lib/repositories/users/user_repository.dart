import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    var url = 'https://3e2f05b8.ngrok.io/api-token-auth/';
    var response = await http.post(url,
        body: {"username": username, "email": "", "password": password});

    print(response.body);

    Map response_map = jsonDecode(response.body);
    persistToken(response_map['token']);

    return response_map['token'];
  }

  Future<String> register({
    @required String username,
    @required String password,
    @required String email,
  }) async {
    var url = 'https://3e2f05b8.ngrok.io/api/v1/rest-auth/registration/';
    var response = await http.post(url,
        body: {"username": username,
               "email": email,
               "password1": password,
               "password2": password});

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
