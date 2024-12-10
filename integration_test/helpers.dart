import 'package:flutter_test/flutter_test.dart';
import 'package:spotspeak_mobile/app.dart';

Future<void> launchAppAndLogIn(WidgetTester tester) async {
  await tester.pumpWidget(App());
  await tester.pumpAndSettle();

  final loginButton = find.text('Logowanie');

  expect(loginButton, findsOneWidget);

  await tester.tap(loginButton);

  await tester.pumpAndSettle();
}
