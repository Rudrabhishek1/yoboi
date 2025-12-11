import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:engineers_mate/features/history/history_screen.dart';
import 'package:engineers_mate/core/services/history_service.dart';

void main() {
  testWidgets('History Screen displays empty state', (WidgetTester tester) async {
    // Mock SharedPrefs
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const MaterialApp(home: HistoryScreen()));
    await tester.pump(); // FutureBuilder

    expect(find.text('No history yet'), findsOneWidget);
  });

  test('HistoryService saves and retrieves data', () async {
    SharedPreferences.setMockInitialValues({});

    final service = HistoryService();
    await service.saveCalculation("Test Formula", "42.00 m");

    final history = await service.getHistory();
    expect(history.length, 1);
    expect(history.first.formulaTitle, "Test Formula");
    expect(history.first.result, "42.00 m");
  });
}
