import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group(
    'login test',
    () {
      testWidgets(
        'log in to app',
        (tester) async {
          await launchAppAndLogIn(tester);
        },
      );
    },
  );
}
