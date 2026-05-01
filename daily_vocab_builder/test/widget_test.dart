import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:daily_vocab_builder/main.dart';

void main() {
  testWidgets('DailyVocabApp navigation smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const DailyVocabApp());
    await tester.pumpAndSettle();

    // App should start on Daily Word
    expect(find.text('Daily Vocab Builder'), findsOneWidget);
    expect(find.byIcon(Icons.book), findsOneWidget);

    // Tap Quiz tab
    await tester.tap(find.byIcon(Icons.quiz));
    await tester.pumpAndSettle();
    expect(find.text('What is the definition of:'), findsOneWidget);

    // Tap Scoreboard tab
    await tester.tap(find.byIcon(Icons.leaderboard));
    await tester.pumpAndSettle();
    expect(find.text('Your Total Score'), findsOneWidget);
  });
}
