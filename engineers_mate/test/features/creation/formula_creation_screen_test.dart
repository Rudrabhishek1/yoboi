import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:engineers_mate/features/creation/formula_creation_screen.dart';

void main() {
  Widget createTestWidget() {
    return const ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: FormulaCreationScreen(),
        ),
      ),
    );
  }

  testWidgets('Should show error SnackBar when fields are empty', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    // Tap Save without filling anything
    await tester.tap(find.text('Save Formula'));
    await tester.pumpAndSettle(); // Complete SnackBar animation

    expect(find.text('Please fill all fields'), findsOneWidget);
  });

  testWidgets('Should show error SnackBar when expression is invalid', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    // Fill valid title and variables
    await tester.enterText(find.widgetWithText(TextField, 'Formula Title'), 'Test Formula');
    await tester.enterText(find.widgetWithText(TextField, 'Variables (comma separated)'), 'x');

    // Fill invalid expression
    await tester.enterText(find.widgetWithText(TextField, 'Equation'), 'x + * 1');

    // Tap Save
    await tester.tap(find.text('Save Formula'));
    await tester.pumpAndSettle(); // Complete SnackBar animation

    expect(find.textContaining('Invalid Expression:'), findsOneWidget);
  });

  testWidgets('Should show error SnackBar when variable is missing in binding', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    // Fill valid title
    await tester.enterText(find.widgetWithText(TextField, 'Formula Title'), 'Test Formula');
    // x is in expression but not in variables list
    await tester.enterText(find.widgetWithText(TextField, 'Variables (comma separated)'), 'y');
    await tester.enterText(find.widgetWithText(TextField, 'Equation'), 'x + 1');

    // Tap Save
    await tester.tap(find.text('Save Formula'));
    await tester.pumpAndSettle(); // Complete SnackBar animation

    // evaluate() should throw because x is not bound
    expect(find.textContaining('Invalid Expression:'), findsOneWidget);
  });
}
