import 'package:flutter_test/flutter_test.dart';
import 'package:spotspeak_mobile/app.dart';

void main() {
  group(
    'trace test',
    () {
      testWidgets(
        'log in to app, add text trace',
        (tester) async {
          await tester.pumpWidget(App());
          await tester.pumpAndSettle();

          final loginButton = find.text('Logowanie');

          expect(loginButton, findsOneWidget);

          await tester.tap(loginButton);

          await tester.pumpAndSettle();

          expect(find.text('1'), findsOneWidget);
        },
      );
    },
  );
}
