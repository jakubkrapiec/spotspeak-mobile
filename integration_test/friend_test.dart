import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/widgets/friend_tile.dart';

import 'helpers.dart';

void main() {
  group(
    'friend test',
    () {
      testWidgets(
        'send friend invitation',
        (tester) async {
          await launchAppAndLogIn(tester);

          final addTraceButton = find.byKey(ValueKey('bottom_nav_friends'));
          expect(addTraceButton, findsOneWidget);
          await tester.tap(addTraceButton);
          await tester.pumpAndSettle();

          final searchTabButton = find.text('Szukaj');
          expect(searchTabButton, findsOneWidget);
          await tester.tap(searchTabButton);
          await tester.pumpAndSettle();

          final friendSearchField = find.byKey(ValueKey('friend_search_field'));
          expect(friendSearchField, findsOneWidget);
          await tester.enterText(friendSearchField, 'ania');
          await tester.pumpAndSettle();

          final result = find.byType(FriendTile);
          expect(result, findsWidgets);
          await tester.tap(result.first);
          await tester.pumpAndSettle();

          final sendInvitationButton = find.text('Zaproś do znajomych');
          expect(sendInvitationButton, findsOneWidget);
          await tester.tap(sendInvitationButton);
          await tester.pumpAndSettle();

          final cancelInvitationButton = find.text('Anuluj zaproszenie');
          expect(cancelInvitationButton, findsOneWidget);
          await tester.tap(cancelInvitationButton);
          await tester.pumpAndSettle();
        },
      );
    },
  );
}
