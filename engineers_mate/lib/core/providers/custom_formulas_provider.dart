import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math_expressions/math_expressions.dart';
import '../../models/formula.dart';

class CustomFormulaData {
  final String id;
  final String title;
  final List<String> inputLabels; // Variables like 'a', 'b'
  final String expression; // 'a * b'

  CustomFormulaData({
    required this.id,
    required this.title,
    required this.inputLabels,
    required this.expression,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'inputLabels': inputLabels,
      'expression': expression,
    };
  }

  factory CustomFormulaData.fromMap(Map<String, dynamic> map) {
    return CustomFormulaData(
      id: map['id'],
      title: map['title'],
      inputLabels: List<String>.from(map['inputLabels']),
      expression: map['expression'],
    );
  }

  Formula toFormula() {
    return Formula(
      id: id,
      title: title,
      category: 'Custom',
      inputLabels: inputLabels,
      inputUnits: List.filled(inputLabels.length, ''), // No units for custom yet
      resultUnit: '',
      calculate: (inputs) {
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        for (int i = 0; i < inputLabels.length; i++) {
          cm.bindVariable(Variable(inputLabels[i]), Number(inputs[i]));
        }
        return exp.evaluate(EvaluationType.REAL, cm);
      },
    );
  }
}

final customFormulasProvider = AsyncNotifierProvider<CustomFormulasNotifier, List<CustomFormulaData>>(CustomFormulasNotifier.new);

class CustomFormulasNotifier extends AsyncNotifier<List<CustomFormulaData>> {
  static const String _key = 'custom_formulas';
  static const String _keyV2 = 'custom_formulas_v2';
  SharedPreferences? _prefs;

  @override
  Future<List<CustomFormulaData>> build() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _loadFormulas();
  }

  Future<List<CustomFormulaData>> _loadFormulas() async {
    _prefs ??= await SharedPreferences.getInstance();

    // Check for V2 storage
    final String? jsonString = _prefs!.getString(_keyV2);
    if (jsonString != null) {
      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded.map((map) => CustomFormulaData.fromMap(map)).toList();
    }

    // Fallback to V1 and migrate
    final List<String>? jsonList = _prefs!.getStringList(_key);
    if (jsonList == null) return [];

    final formulas = jsonList.map((str) => CustomFormulaData.fromMap(jsonDecode(str))).toList();

    // Migrate
    await _saveFormulasV2(formulas);
    await _prefs!.remove(_key);

    return formulas;
  }

  Future<void> _saveFormulasV2(List<CustomFormulaData> formulas) async {
    _prefs ??= await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(formulas.map((item) => item.toMap()).toList());
    await _prefs!.setString(_keyV2, jsonString);
  }

  Future<void> addFormula(CustomFormulaData data) async {
    _prefs ??= await SharedPreferences.getInstance();
    final currentList = state.value ?? [];
    final newList = [...currentList, data];

    await _saveFormulasV2(newList);

    state = AsyncData(newList);
  }
}
