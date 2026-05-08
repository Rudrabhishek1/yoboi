import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:engineers_mate/features/dashboard/dashboard_screen.dart';
import 'package:engineers_mate/features/dashboard/formula_list_screen.dart';
import 'package:engineers_mate/features/solver/universal_solver_screen.dart';
import 'package:engineers_mate/models/formula.dart';
import 'package:engineers_mate/core/data/electrical_formulas.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('Dashboard renders categories', (WidgetTester tester) async {
    // Set a large screen size to ensure all items are visible without scrolling
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: DashboardScreen())));

    expect(find.text('Electrical'), findsOneWidget);
    expect(find.text('Civil'), findsOneWidget);
    expect(find.text('Mechanical'), findsOneWidget);

    // Reset view
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });

  testWidgets('Clicking Electrical opens Formula List',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: DashboardScreen())));

    await tester.tap(find.text('Electrical'));
    await tester.pumpAndSettle();

    expect(find.byType(FormulaListScreen), findsOneWidget);
    expect(find.text('Ohm\'s Law (Find V)'), findsOneWidget);
  });

  testWidgets('Universal Solver calculates correctly',
      (WidgetTester tester) async {
    final formula = Formula(
      id: 'test',
      title: 'Test Formula',
      category: 'Test',
      inputLabels: ['A', 'B'],
      inputUnits: ['u', 'u'],
      resultUnit: 'r',
      calculate: (inputs) => inputs[0] + inputs[1],
    );

    await tester.pumpWidget(ProviderScope(
        child: MaterialApp(home: UniversalSolverScreen(formula: formula))));

    // Enter values
    await tester.enterText(find.byType(TextField).at(0), '10');
    await tester.enterText(find.byType(TextField).at(1), '5');

    // Calculate
    await tester.tap(find.text('Calculate'));
    await tester.pump();

    // Check result
    expect(find.text('15.00 r'), findsOneWidget);
  });

  testWidgets('Ohm\'s Law Logic Test', (WidgetTester tester) async {
    final formula = electricalFormulas.firstWhere((f) => f.id == 'ohms_law_v');

    expect(formula.calculate([2.0, 10.0]), 20.0); // V = I * R = 2 * 10 = 20
  });
}
