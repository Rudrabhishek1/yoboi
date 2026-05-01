import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:daily_vocab_builder/main.dart';

void main() {
  testWidgets('DailyVocabApp smoke test', (WidgetTester tester) async {
    // Set up mock SharedPreferences
    SharedPreferences.setMockInitialValues({});

    // Build our app and trigger a frame.
    await tester.pumpWidget(const DailyVocabApp());

    // Allow time for the futures (like SharedPreferences) to resolve
    await tester.pump();

    // Verify that the title is present
    expect(find.text('Word of the Day'), findsOneWidget);

    // Verify that some text is displayed (either loading or a word)
    expect(find.byType(Text), findsWidgets);
  });
}
