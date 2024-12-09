import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:integration_test/integration_test.dart';

import 'package:spotspeak_mobile/bootstrap.dart';

import 'trace_test.dart' as trace_test;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await prepareApp(mode: const Environment(Environment.test));
  });

  trace_test.main();
}
