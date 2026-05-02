import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Model
class HistoryItem {
  final String formulaTitle;
  final String result;
  final DateTime timestamp;

  HistoryItem({
    required this.formulaTitle,
    required this.result,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'formulaTitle': formulaTitle,
      'result': result,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory HistoryItem.fromMap(Map<String, dynamic> map) {
    return HistoryItem(
      formulaTitle: map['formulaTitle'],
      result: map['result'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}

// Provider
final historyProvider = AsyncNotifierProvider<HistoryNotifier, List<HistoryItem>>(HistoryNotifier.new);

class HistoryNotifier extends AsyncNotifier<List<HistoryItem>> {
  static const String _key = 'calculation_history';
  static const String _keyV2 = 'calculation_history_v2';
  SharedPreferences? _prefs;

  @override
  Future<List<HistoryItem>> build() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _loadHistory();
  }

  Future<List<HistoryItem>> _loadHistory() async {
    _prefs ??= await SharedPreferences.getInstance();

    // Check for V2 storage first (single JSON string)
    final String? jsonString = _prefs!.getString(_keyV2);
    if (jsonString != null) {
      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded.map((map) => HistoryItem.fromMap(map)).toList();
    }

    // Fallback to V1 storage (list of JSON strings) and migrate
    final List<String>? jsonList = _prefs!.getStringList(_key);
    if (jsonList == null) return [];

    final history = jsonList.map((str) => HistoryItem.fromMap(jsonDecode(str))).toList();

    // Migrate to V2
    await _saveHistoryV2(history);
    await _prefs!.remove(_key);

    return history;
  }

  Future<void> _saveHistoryV2(List<HistoryItem> history) async {
    _prefs ??= await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(history.map((item) => item.toMap()).toList());
    await _prefs!.setString(_keyV2, jsonString);
  }

  Future<void> addToHistory(String formulaTitle, String result) async {
    _prefs ??= await SharedPreferences.getInstance();
    final currentList = state.value ?? [];

    final newItem = HistoryItem(
      formulaTitle: formulaTitle,
      result: result,
      timestamp: DateTime.now(),
    );

    final newList = [newItem, ...currentList];
    if (newList.length > 20) {
      newList.removeRange(20, newList.length);
    }

    await _saveHistoryV2(newList);

    state = AsyncData(newList);
  }

  Future<void> clearHistory() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.remove(_key);
    await _prefs!.remove(_keyV2);
    state = const AsyncData([]);
  }
}
