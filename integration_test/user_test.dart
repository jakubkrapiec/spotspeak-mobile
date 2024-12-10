import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group(
    'user test',
    () {
      testWidgets(
        'change username',
        (tester) async {
          await launchAppAndLogIn(tester);
          final bottomNavProfileButton = find.byKey(ValueKey('bottom_nav_profile'));
          expect(bottomNavProfileButton, findsOneWidget);
          await tester.tap(bottomNavProfileButton);
          await tester.pumpAndSettle();

          final accountSettingsButton = find.text('Ustawienia konta');
          expect(accountSettingsButton, findsOneWidget);
          await tester.tap(accountSettingsButton);
          await tester.pumpAndSettle();

          final changeUsernameButton = find.text('Zmiana nazwy użytkownika');
          expect(changeUsernameButton, findsOneWidget);
          await tester.tap(changeUsernameButton);
          await tester.pumpAndSettle();

          final newUsername = 'test${DateTime.now().millisecondsSinceEpoch}';
          final usernameTextField = find.byKey(ValueKey('username_field'));
          expect(usernameTextField, findsOneWidget);
          await tester.enterText(usernameTextField, newUsername);

          final passwordTextField = find.byKey(ValueKey('confirm_password_field'));
          expect(passwordTextField, findsOneWidget);
          await tester.enterText(passwordTextField, 'TestPassword12!');

          final submitButton = find.text('Zatwierdź');
          expect(submitButton, findsOneWidget);
          await tester.tap(submitButton);
          await tester.pumpAndSettle();

          final accountScreenHeader = find.text('Informacje o koncie');
          expect(accountScreenHeader, findsOneWidget);

          await tester.pageBack();
          await tester.pumpAndSettle();

          final username = find.text(newUsername);
          expect(username, findsOneWidget);
        },
      );

      testWidgets(
        'try to set the same username',
        (tester) async {
          await launchAppAndLogIn(tester);
          final bottomNavProfileButton = find.byKey(ValueKey('bottom_nav_profile'));
          expect(bottomNavProfileButton, findsOneWidget);
          await tester.tap(bottomNavProfileButton);
          await tester.pumpAndSettle();

          final accountSettingsButton = find.text('Ustawienia konta');
          expect(accountSettingsButton, findsOneWidget);
          await tester.tap(accountSettingsButton);
          await tester.pumpAndSettle();

          final changeUsernameButton = find.text('Zmiana nazwy użytkownika');
          expect(changeUsernameButton, findsOneWidget);
          await tester.tap(changeUsernameButton);
          await tester.pumpAndSettle();

          final passwordTextField = find.byKey(ValueKey('confirm_password_field'));
          expect(passwordTextField, findsOneWidget);
          await tester.enterText(passwordTextField, 'TestPassword12!');

          final submitButton = find.text('Zatwierdź');
          expect(submitButton, findsOneWidget);
          await tester.tap(submitButton);
          await tester.pumpAndSettle();

          final errorMessage = find.textContaining('Nazwa musi być inna niż aktualna');
          expect(errorMessage, findsOneWidget);
        },
      );

      testWidgets(
        'try to change username with wrong password',
        (tester) async {
          await launchAppAndLogIn(tester);
          final bottomNavProfileButton = find.byKey(ValueKey('bottom_nav_profile'));
          expect(bottomNavProfileButton, findsOneWidget);
          await tester.tap(bottomNavProfileButton);
          await tester.pumpAndSettle();

          final accountSettingsButton = find.text('Ustawienia konta');
          expect(accountSettingsButton, findsOneWidget);
          await tester.tap(accountSettingsButton);
          await tester.pumpAndSettle();

          final changeUsernameButton = find.text('Zmiana nazwy użytkownika');
          expect(changeUsernameButton, findsOneWidget);
          await tester.tap(changeUsernameButton);
          await tester.pumpAndSettle();

          final newUsername = 'test${DateTime.now().millisecondsSinceEpoch}';
          final usernameTextField = find.byKey(ValueKey('username_field'));
          expect(usernameTextField, findsOneWidget);
          await tester.enterText(usernameTextField, newUsername);

          final submitButton = find.text('Zatwierdź');
          expect(submitButton, findsOneWidget);
          await tester.tap(submitButton);
          await tester.pumpAndSettle();

          final confirmPasswordText = find.text('Potwierdź hasło:');
          expect(confirmPasswordText, findsOneWidget);
        },
      );

      testWidgets(
        'try to set invalid username',
        (tester) async {
          await launchAppAndLogIn(tester);
          final bottomNavProfileButton = find.byKey(ValueKey('bottom_nav_profile'));
          expect(bottomNavProfileButton, findsOneWidget);
          await tester.tap(bottomNavProfileButton);
          await tester.pumpAndSettle();

          final accountSettingsButton = find.text('Ustawienia konta');
          expect(accountSettingsButton, findsOneWidget);
          await tester.tap(accountSettingsButton);
          await tester.pumpAndSettle();

          final changeUsernameButton = find.text('Zmiana nazwy użytkownika');
          expect(changeUsernameButton, findsOneWidget);
          await tester.tap(changeUsernameButton);
          await tester.pumpAndSettle();

          final newUsername = 'test/${DateTime.now().millisecondsSinceEpoch}';
          final usernameTextField = find.byKey(ValueKey('username_field'));
          expect(usernameTextField, findsOneWidget);
          await tester.enterText(usernameTextField, newUsername);

          final passwordTextField = find.byKey(ValueKey('confirm_password_field'));
          expect(passwordTextField, findsOneWidget);
          await tester.enterText(passwordTextField, 'TestPassword12!');

          final submitButton = find.text('Zatwierdź');
          expect(submitButton, findsOneWidget);
          await tester.tap(submitButton);
          await tester.pumpAndSettle();

          final errorMessage = find.textContaining('Nieprawidłowa nazwa użytkownika');
          expect(errorMessage, findsOneWidget);
        },
      );
    },
  );
}
