import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';
import '../../core/providers/custom_formulas_provider.dart';

class FormulaCreationScreen extends ConsumerStatefulWidget {
  const FormulaCreationScreen({super.key});

  @override
  ConsumerState<FormulaCreationScreen> createState() => _FormulaCreationScreenState();
}

class _FormulaCreationScreenState extends ConsumerState<FormulaCreationScreen> {
  final _titleController = TextEditingController();
  final _expressionController = TextEditingController();
  final _variablesController = TextEditingController(); // Comma separated for now

  void _save() async {
    final title = _titleController.text;
    final expression = _expressionController.text;
    final variablesStr = _variablesController.text;

    if (title.isEmpty || expression.isEmpty || variablesStr.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    final variables = variablesStr.split(',').map((e) => e.trim()).toList();

    // Validate Expression
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      // Try to evaluate with 1.0 for all variables to check validity
      ContextModel cm = ContextModel();
      for (var v in variables) {
        cm.bindVariable(Variable(v), Number(1.0));
      }
      exp.evaluate(EvaluationType.REAL, cm);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Expression: $e")));
      return;
    }

    final newFormula = CustomFormulaData(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      inputLabels: variables,
      expression: expression,
    );

    await ref.read(customFormulasProvider.notifier).addFormula(newFormula);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Formula")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(labelText: "Formula Title", hintText: "e.g. My Kinetic Energy", counterText: ""),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _variablesController,
              maxLength: 100,
              decoration: const InputDecoration(labelText: "Variables (comma separated)", hintText: "m, v", counterText: ""),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _expressionController,
              maxLength: 255,
              decoration: const InputDecoration(labelText: "Equation", hintText: "0.5 * m * v^2", counterText: ""),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _save,
                child: const Text("Save Formula"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
