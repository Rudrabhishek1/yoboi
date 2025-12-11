import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/formula.dart';

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

class HistoryService {
  static const String _key = 'calculation_history';

  Future<void> saveCalculation(String formulaTitle, String result) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getHistory();

    // Create new item
    final newItem = HistoryItem(
      formulaTitle: formulaTitle,
      result: result,
      timestamp: DateTime.now(),
    );

    // Add to top
    history.insert(0, newItem);

    // Limit to 20 items
    if (history.length > 20) {
      history.removeRange(20, history.length);
    }

    // Save
    final List<String> jsonList = history.map((item) => jsonEncode(item.toMap())).toList();
    await prefs.setStringList(_key, jsonList);
  }

  Future<List<HistoryItem>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(_key);

    if (jsonList == null) return [];

    return jsonList.map((str) => HistoryItem.fromMap(jsonDecode(str))).toList();
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
