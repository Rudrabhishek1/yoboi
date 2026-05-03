import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:engineers_mate/features/converter/quick_convert_screen.dart';
import 'package:engineers_mate/features/creation/formula_creation_screen.dart';
import 'package:engineers_mate/features/dashboard/dashboard_screen.dart';
import 'package:engineers_mate/features/solver/universal_solver_screen.dart';
import 'package:engineers_mate/models/formula.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('QuickConvertScreen enforces maxLength on input', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: QuickConvertScreen()));

    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);

    final TextField textField = tester.widget(textFieldFinder);
    expect(textField.maxLength, 50);
  });

  testWidgets('FormulaCreationScreen enforces maxLength on inputs', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: FormulaCreationScreen())));

    final textFields = find.byType(TextField);
    expect(textFields, findsNWidgets(3));

    final titleField = tester.widget<TextField>(textFields.at(0));
    final variablesField = tester.widget<TextField>(textFields.at(1));
    final equationField = tester.widget<TextField>(textFields.at(2));

    expect(titleField.maxLength, 50);
    expect(variablesField.maxLength, 200);
    expect(equationField.maxLength, 200);
  });

  testWidgets('DashboardScreen search enforces maxLength', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: DashboardScreen())));

    // Open search
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    final searchFieldFinder = find.byType(TextField);
    expect(searchFieldFinder, findsOneWidget);

    final TextField searchField = tester.widget(searchFieldFinder);
    expect(searchField.maxLength, 50);
  });

  testWidgets('UniversalSolverScreen enforces maxLength on inputs', (WidgetTester tester) async {
    final formula = Formula(
      id: 'test',
      title: 'Test Formula',
      category: 'Test',
      inputLabels: ['x', 'y'],
      inputUnits: ['m', 's'],
      resultUnit: 'm/s',
      calculate: (inputs) => inputs[0] / inputs[1],
    );

    await tester.pumpWidget(ProviderScope(child: MaterialApp(home: UniversalSolverScreen(formula: formula))));

    final textFields = find.byType(TextField);
    expect(textFields, findsNWidgets(2));

    final field1 = tester.widget<TextField>(textFields.at(0));
    final field2 = tester.widget<TextField>(textFields.at(1));

    expect(field1.maxLength, 50);
    expect(field2.maxLength, 50);
  });
}
