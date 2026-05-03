import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:engineers_mate/features/history/history_screen.dart';

void main() {
  testWidgets('History Screen displays empty state', (WidgetTester tester) async {
    // Mock SharedPrefs
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: HistoryScreen()),
      ),
    );
    await tester.pump(); // Provider initialization

    expect(find.text('No history yet'), findsOneWidget);
  });
}
