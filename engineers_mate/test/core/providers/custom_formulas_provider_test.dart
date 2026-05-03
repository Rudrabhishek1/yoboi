import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:engineers_mate/core/providers/custom_formulas_provider.dart';

void main() {
  test('CustomFormulasNotifier limits formulas to 20', () async {
    SharedPreferences.setMockInitialValues({});

    final container = ProviderContainer();

    // Initial load
    await container.read(customFormulasProvider.future);

    final notifier = container.read(customFormulasProvider.notifier);

    // Add 25 formulas
    for (int i = 0; i < 25; i++) {
      await notifier.addFormula(CustomFormulaData(
        id: 'id_$i',
        title: 'Formula $i',
        inputLabels: ['x'],
        expression: 'x + $i',
      ));
    }

    final formulas = await container.read(customFormulasProvider.future);
    // After the fix, it should be limited to 20
    expect(formulas.length, 20);

    // It should keep the most recent ones (Formula 5 to Formula 24)
    expect(formulas.first.id, 'id_5');
    expect(formulas.last.id, 'id_24');
  });
}
