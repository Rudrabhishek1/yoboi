import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:engineers_mate/core/providers/history_provider.dart';

void main() {
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

  test('HistoryNotifier clears history', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();

    // Add something to history first
    await container.read(historyProvider.notifier).addToHistory("To Be Cleared", "100");
    var history = await container.read(historyProvider.future);
    expect(history.length, 1);

    // Clear history
    await container.read(historyProvider.notifier).clearHistory();

    // Verify provider state
    history = await container.read(historyProvider.future);
    expect(history, isEmpty);

    // Verify SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.containsKey('calculation_history'), isFalse);
  });

  test('HistoryNotifier maintains 20 item limit', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();

    // Add 25 items
    for (int i = 1; i <= 25; i++) {
      await container.read(historyProvider.notifier).addToHistory("Formula $i", "$i");
    }

    final history = await container.read(historyProvider.future);

    // Should only have 20
    expect(history.length, 20);

    // Should have the most recent ones (25 down to 6)
    expect(history.first.formulaTitle, "Formula 25");
    expect(history.last.formulaTitle, "Formula 6");
  });
}
