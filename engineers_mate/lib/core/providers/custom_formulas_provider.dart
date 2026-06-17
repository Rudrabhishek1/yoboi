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
    Expression? cachedExp;
    return Formula(
      id: id,
      title: title,
      category: 'Custom',
      inputLabels: inputLabels,
      inputUnits: List.filled(
        inputLabels.length,
        '',
      ), // No units for custom yet
      resultUnit: '',
      calculate: (inputs) {
        // ⚡ Bolt: Lazy load and cache the parsed expression to prevent redundant expensive parsing on every evaluation
        cachedExp ??= Parser().parse(expression);
        ContextModel cm = ContextModel();
        for (int i = 0; i < inputLabels.length; i++) {
          cm.bindVariable(Variable(inputLabels[i]), Number(inputs[i]));
        }
        return cachedExp!.evaluate(EvaluationType.REAL, cm);
      },
    );
  }
}

final customFormulasProvider =
    AsyncNotifierProvider<CustomFormulasNotifier, List<CustomFormulaData>>(
      CustomFormulasNotifier.new,
    );

class CustomFormulasNotifier extends AsyncNotifier<List<CustomFormulaData>> {
  static const String _key = 'custom_formulas';

  @override
  Future<List<CustomFormulaData>> build() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(_key);
    if (jsonList == null) return [];
    return jsonList
        .map((str) => CustomFormulaData.fromMap(jsonDecode(str)))
        .toList();
  }

  Future<void> addFormula(CustomFormulaData data) async {
    final prefs = await SharedPreferences.getInstance();
    final currentList = state.value ?? [];
    final newList = [...currentList, data];

    final List<String> jsonList = newList
        .map((item) => jsonEncode(item.toMap()))
        .toList();
    await prefs.setStringList(_key, jsonList);

    state = AsyncData(newList);
  }
}
