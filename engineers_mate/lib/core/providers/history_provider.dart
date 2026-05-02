import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/formula.dart';

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
  SharedPreferences? _prefs;
  List<String> _jsonList = [];

  @override
  Future<List<HistoryItem>> build() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _loadHistory();
  }

  Future<List<HistoryItem>> _loadHistory() async {
    _prefs ??= await SharedPreferences.getInstance();
    _jsonList = _prefs!.getStringList(_key) ?? [];
    return _jsonList.map((str) => HistoryItem.fromMap(jsonDecode(str))).toList();
  }

  Future<void> addToHistory(String formulaTitle, String result) async {
    _prefs ??= await SharedPreferences.getInstance();
    final currentList = state.value ?? [];

    final newItem = HistoryItem(
      formulaTitle: formulaTitle,
      result: result,
      timestamp: DateTime.now(),
    );

    final newItemJson = jsonEncode(newItem.toMap());
    final newList = [newItem, ...currentList];
    _jsonList = [newItemJson, ..._jsonList];

    if (newList.length > 20) {
      newList.removeRange(20, newList.length);
      _jsonList.removeRange(20, _jsonList.length);
    }

    await _prefs!.setStringList(_key, _jsonList);

    state = AsyncData(newList);
  }

  Future<void> clearHistory() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.remove(_key);
    _jsonList = [];
    state = const AsyncData([]);
  }
}
