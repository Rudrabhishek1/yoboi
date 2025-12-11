import 'package:flutter_test/flutter_test.dart';
import 'package:engineers_mate/core/services/firebase_service.dart';
import 'package:engineers_mate/core/providers/custom_formulas_provider.dart';

void main() {
  test('FirebaseService fails gracefully without keys', () async {
    // This verifies our try-catch block works
    // In this test env, there is no google-services.json, so it should print error and not crash.
    await FirebaseService.initialize();

    // Fetch should return empty
    final list = await FirebaseService.fetchRemoteFormulas();
    expect(list, isEmpty);
  });

  // Since we can't easily mock FirebaseRemoteConfig static instance without a heavy mock library,
  // We will verify the parsing logic by creating a dummy JSON and parsing it using the model directly.
  test('CustomFormulaData parses from JSON', () {
     final jsonMap = {
       "id": "remote_1",
       "title": "Remote Formula",
       "inputLabels": ["x", "y"],
       "expression": "x + y"
     };

     final data = CustomFormulaData.fromMap(jsonMap);
     expect(data.title, "Remote Formula");
     expect(data.inputLabels, ["x", "y"]);

     final formula = data.toFormula();
     expect(formula.calculate([10, 5]), 15.0);
  });
}
