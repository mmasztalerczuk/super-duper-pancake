// Import the test package and Counter class
import 'package:flutter_test/flutter_test.dart';
import 'package:questlly/repositories/users/user_repository.dart';


void main() {
  test('Empty test', () {});
  test('UserRepository authenticate', () {
    final userRepository = UserRepository();
    final username = 'test_login';
    final password = 'password_login';

    final responseJson =
      userRepository.authenticate(username: username, password: password);
  });
}
