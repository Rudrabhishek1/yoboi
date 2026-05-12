import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:engineers_mate/core/services/firebase_service.dart';
import 'package:engineers_mate/core/providers/custom_formulas_provider.dart';

class MockFirebasePlatformError extends FirebasePlatform {
  @override
  FirebaseAppPlatform app([String name = defaultFirebaseAppName]) {
    throw Exception('Mocked app not found');
  }

  @override
  Future<FirebaseAppPlatform> initializeApp({
    String? name,
    FirebaseOptions? options,
  }) async {
    throw Exception('Simulated Firebase Initialization Error');
  }
}

void main() {
  test('FirebaseService initialize gracefully catches Firebase initialization errors via Mock', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final original = FirebasePlatform.instance;
    addTearDown(() {
      FirebasePlatform.instance = original;
    });

    FirebasePlatform.instance = MockFirebasePlatformError();

    // Call initialize, it should catch the exception silently
    await FirebaseService.initialize();

    // Trying to fetch data should return empty list since it failed to initialize
    final list = await FirebaseService.fetchRemoteFormulas();
    expect(list, isEmpty);
  });

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
