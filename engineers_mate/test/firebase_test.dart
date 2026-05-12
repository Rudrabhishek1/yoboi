import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:firebase_remote_config_platform_interface/firebase_remote_config_platform_interface.dart';
import 'package:engineers_mate/core/services/firebase_service.dart';
import 'package:engineers_mate/core/providers/custom_formulas_provider.dart';

class MockFirebasePlatform extends FirebasePlatform {
  @override
  FirebaseAppPlatform app([String name = defaultFirebaseAppName]) {
    return MockFirebaseAppPlatform(name, const FirebaseOptions(
      apiKey: 'test', appId: 'test', messagingSenderId: 'test', projectId: 'test'
    ));
  }

  @override
  Future<FirebaseAppPlatform> initializeApp({
    String? name,
    FirebaseOptions? options,
  }) async {
    return app(name ?? defaultFirebaseAppName);
  }
}

class MockFirebaseAppPlatform extends FirebaseAppPlatform {
  MockFirebaseAppPlatform(String name, FirebaseOptions options) : super(name, options);
}

class MockRemoteConfigPlatform extends FirebaseRemoteConfigPlatform {
  String mockJson = 'invalid json';

  @override
  FirebaseRemoteConfigPlatform delegateFor({required FirebaseApp app}) {
    return this;
  }

  @override
  Future<void> setConfigSettings(RemoteConfigSettings settings) async {}

  @override
  Future<void> setDefaults(Map<String, dynamic> defaultParameters) async {}

  @override
  Future<bool> fetchAndActivate() async {
    return true;
  }

  @override
  FirebaseRemoteConfigPlatform setInitialValues({required Map<dynamic, dynamic> remoteConfigValues}) {
    return this;
  }

  @override
  String getString(String key) {
    if (key == 'remote_formulas') {
      return mockJson;
    }
    return '';
  }
}

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

  test('fetchRemoteFormulas returns empty list on invalid JSON', () async {
    // Setup Mocks
    FirebasePlatform.instance = MockFirebasePlatform();
    FirebaseRemoteConfigPlatform.instance = MockRemoteConfigPlatform();

    // Test initialization
    await FirebaseService.initialize();

    // Fetch should gracefully handle invalid JSON and return an empty list
    final formulas = await FirebaseService.fetchRemoteFormulas();
    expect(formulas, isEmpty);
  });
}
