import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:engineers_mate/features/solver/universal_solver_screen.dart';
import 'package:engineers_mate/models/formula.dart';

void main() {
  testWidgets('UniversalSolverScreen shows SnackBar on invalid input', (WidgetTester tester) async {
    // Mock SharedPreferences for HistoryNotifier
    SharedPreferences.setMockInitialValues({});

    final formula = Formula(
      id: 'test_formula',
      title: 'Test Formula',
      category: 'Test',
      inputLabels: ['Value A'],
      inputUnits: ['unit'],
      resultUnit: 'res',
      calculate: (inputs) => inputs[0] * 2,
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: UniversalSolverScreen(formula: formula),
        ),
      ),
    );

    // Enter invalid text
    await tester.enterText(find.byType(TextField), 'not-a-number');

    // Tap Calculate button
    await tester.tap(find.text('Calculate'));

    // Pump to show SnackBar
    await tester.pump();

    // Verify SnackBar is shown with correct message
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Please enter valid numbers'), findsOneWidget);
  });

  testWidgets('UniversalSolverScreen shows SnackBar when one of multiple inputs is invalid', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    final formula = Formula(
      id: 'test_multi',
      title: 'Multi Test',
      category: 'Test',
      inputLabels: ['A', 'B'],
      inputUnits: ['u', 'u'],
      resultUnit: 'r',
      calculate: (inputs) => inputs[0] + inputs[1],
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: UniversalSolverScreen(formula: formula),
        ),
      ),
    );

    // Enter one valid and one invalid
    await tester.enterText(find.byType(TextField).at(0), '10');
    await tester.enterText(find.byType(TextField).at(1), 'abc');

    await tester.tap(find.text('Calculate'));
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Please enter valid numbers'), findsOneWidget);
  });
}
