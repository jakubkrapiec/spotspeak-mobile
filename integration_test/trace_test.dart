import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spotspeak_mobile/screens/users_traces/trace_tile.dart';

import 'helpers.dart';

void main() {
  group(
    'trace test',
    () {
      testWidgets(
        'add text trace',
        (tester) async {
          await launchAppAndLogIn(tester);

          final addTraceButton = find.byKey(ValueKey('add_trace'));
          expect(addTraceButton, findsOneWidget);
          await tester.tap(addTraceButton);
          await tester.pumpAndSettle();

          final traceTextField = find.byKey(ValueKey('trace_text_field'));
          expect(traceTextField, findsOneWidget);
          await tester.enterText(traceTextField, 'Tutaj jest fajne miejsce');

          final submitButton = find.text('Dodaj ślad');
          expect(submitButton, findsOneWidget);
          await tester.tap(submitButton);
          await tester.pumpAndSettle();

          final errorInfo = find.text('Nie udało się dodać śladu');
          expect(errorInfo, findsNothing);
        },
      );

      testWidgets(
        'error on trying to add an empty trace',
        (tester) async {
          await launchAppAndLogIn(tester);

          final addTraceButton = find.byKey(ValueKey('add_trace'));
          expect(addTraceButton, findsOneWidget);
          await tester.tap(addTraceButton);
          await tester.pumpAndSettle();

          final submitButton = find.text('Dodaj ślad');
          expect(submitButton, findsOneWidget);
          await tester.tap(submitButton);
          await tester.pumpAndSettle();

          final errorInfo = find.text('Dodaj opis lub media');
          expect(errorInfo, findsOneWidget);
        },
      );

      testWidgets(
        'see and sort added traces',
        (tester) async {
          await launchAppAndLogIn(tester);
          final bottomNavProfileButton = find.byKey(ValueKey('bottom_nav_profile'));
          expect(bottomNavProfileButton, findsOneWidget);
          await tester.tap(bottomNavProfileButton);
          await tester.pumpAndSettle();

          final addedTracesButton = find.text('Dodane ślady');
          expect(addedTracesButton, findsOneWidget);
          await tester.tap(addedTracesButton);
          await tester.pumpAndSettle();

          final traces = find.byType(TraceTile);
          expect(traces, findsWidgets);

          final sortingButton = find.byKey(ValueKey('sorting_button'));
          expect(sortingButton, findsOneWidget);
          await tester.tap(sortingButton);
          await tester.pumpAndSettle();

          final oldestFirstButton = find.text('Od najstarszego');
          expect(oldestFirstButton, findsOneWidget);
          await tester.tap(oldestFirstButton);
          await tester.pumpAndSettle();

          final newTraces = find.byType(TraceTile);
          expect(newTraces, findsWidgets);
        },
      );
    },
  );
}
