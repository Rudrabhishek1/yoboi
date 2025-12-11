import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:engineers_mate/features/history/history_screen.dart';
import 'package:engineers_mate/core/providers/history_provider.dart';

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

  test('HistoryNotifier saves and retrieves data', () async {
    SharedPreferences.setMockInitialValues({});

    final container = ProviderContainer();

    // Initial load
    await container.read(historyProvider.future);

    await container.read(historyProvider.notifier).addToHistory("Test Formula", "42.00 m");

    final history = await container.read(historyProvider.future);
    expect(history.length, 1);
    expect(history.first.formulaTitle, "Test Formula");
    expect(history.first.result, "42.00 m");
  });
}
