import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:integration_test/integration_test.dart';
import 'package:spotspeak_mobile/bootstrap.dart';
import 'package:spotspeak_mobile/di/get_it.dart';

import 'friend_test.dart' as friend_test;
import 'login_test.dart' as login_test;
import 'trace_test.dart' as trace_test;
import 'user_test.dart' as user_test;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() async {
    await getIt.reset();
    await prepareApp(mode: const Environment(Environment.test));
  });

  login_test.main();
  trace_test.main();
  user_test.main();
  friend_test.main();
}
