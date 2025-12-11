import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/formula.dart';
import '../providers/custom_formulas_provider.dart';

// Service to handle low-level Firebase interactions
class FirebaseService {
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) return;
    try {
      // In a real app, you might use DefaultFirebaseOptions.currentPlatform
      // For this dynamic bootstrapping, we assume the user sets it up or it's auto-detected (Android/iOS)
      // If running in an environment without google-services.json, this might fail.
      await Firebase.initializeApp();

      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1), // Cache for 1 hour
      ));

      // Defaults
      await remoteConfig.setDefaults(const {
        "remote_formulas": "[]",
      });

      await remoteConfig.fetchAndActivate();
      _isInitialized = true;
      debugPrint("Firebase Initialized Successfully");
    } catch (e) {
      debugPrint("Firebase Initialization Failed (Expected in Test/No-Key Env): $e");
    }
  }

  static Future<List<CustomFormulaData>> fetchRemoteFormulas() async {
    if (!_isInitialized) return [];
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      final jsonString = remoteConfig.getString('remote_formulas');
      if (jsonString.isEmpty) return [];

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((map) => CustomFormulaData.fromMap(map)).toList();
    } catch (e) {
      debugPrint("Error parsing remote formulas: $e");
      return [];
    }
  }
}

// Provider
final remoteFormulasProvider = FutureProvider<List<Formula>>((ref) async {
  // We don't want to block the UI, so we return empty first if not ready?
  // Actually FutureProvider works well.

  // Try to init if not already (safeguard)
  // await FirebaseService.initialize(); // Better to do in main, but ok here too.

  final dataList = await FirebaseService.fetchRemoteFormulas();
  return dataList.map((d) => d.toFormula()).toList();
});
