// Import the test package and Counter class
import 'package:flutter_test/flutter_test.dart';
import 'package:questlly/common/exceptions.dart';
import 'package:questlly/repositories/users/user_repository.dart';


void main() {
  test('Empty test', () {});
  test('UserRepository authenticate - No Internet Connection', () async {
    var configuration = new Map();
    configuration['API_URL'] = 'http://unit_test.com';

    final userRepository = UserRepository(configuration: configuration);
    final username = 'test_login';
    final password = 'password_login';

    expect(() async => await userRepository.authenticate(username: username, password: password),

        throwsA(predicate((e) => e is FetchDataException && e.toString() == "Error During Communication: No Internet connection")));
  });
}
