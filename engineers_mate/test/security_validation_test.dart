import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:engineers_mate/features/creation/formula_creation_screen.dart';

void main() {
  group('Formula Creation Security Validation', () {
    testWidgets('Rejects invalid characters in expression', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: FormulaCreationScreen()),
        ),
      );

      await tester.enterText(find.widgetWithText(TextField, 'Formula Title'), 'Test');
      await tester.enterText(find.widgetWithText(TextField, 'Variables (comma separated)'), 'x');
      await tester.enterText(find.widgetWithText(TextField, 'Equation'), 'x; alert(1)');

      await tester.tap(find.text('Save Formula'));
      await tester.pump();

      expect(find.text('Expression contains invalid characters'), findsOneWidget);
    });

    testWidgets('Rejects overly long title', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: FormulaCreationScreen()),
        ),
      );

      await tester.enterText(find.widgetWithText(TextField, 'Formula Title'), 'A' * 51);
      await tester.enterText(find.widgetWithText(TextField, 'Variables (comma separated)'), 'x');
      await tester.enterText(find.widgetWithText(TextField, 'Equation'), 'x * 2');

      await tester.tap(find.text('Save Formula'));
      await tester.pump();

      expect(find.text('Title must be 50 characters or less'), findsOneWidget);
    });

    testWidgets('Rejects invalid variable names', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: FormulaCreationScreen()),
        ),
      );

      await tester.enterText(find.widgetWithText(TextField, 'Formula Title'), 'Test');
      await tester.enterText(find.widgetWithText(TextField, 'Variables (comma separated)'), '1x');
      await tester.enterText(find.widgetWithText(TextField, 'Equation'), 'x * 2');

      await tester.tap(find.text('Save Formula'));
      await tester.pump();

      expect(find.textContaining('Invalid variable name'), findsOneWidget);
    });
  });
}
