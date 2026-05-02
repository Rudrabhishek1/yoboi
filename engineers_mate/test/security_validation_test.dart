import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:engineers_mate/features/creation/formula_creation_screen.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Widget createTestWidget() {
    return const ProviderScope(
      child: MaterialApp(
        home: FormulaCreationScreen(),
      ),
    );
  }

  testWidgets('Should reject long title', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    await tester.enterText(find.widgetWithText(TextField, 'Formula Title'), 'a' * 51);
    await tester.enterText(find.widgetWithText(TextField, 'Variables (comma separated)'), 'x');
    await tester.enterText(find.widgetWithText(TextField, 'Equation'), 'x + 1');

    await tester.tap(find.text('Save Formula'));
    await tester.pumpAndSettle();

    expect(find.text('Title too long (max 50 chars)'), findsOneWidget);
  });

  testWidgets('Should reject long expression', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    await tester.enterText(find.widgetWithText(TextField, 'Formula Title'), 'Valid Title');
    await tester.enterText(find.widgetWithText(TextField, 'Variables (comma separated)'), 'x');
    await tester.enterText(find.widgetWithText(TextField, 'Equation'), 'x' + ' + 0' * 100);

    await tester.tap(find.text('Save Formula'));
    await tester.pumpAndSettle();

    expect(find.text('Expression too long (max 200 chars)'), findsOneWidget);
  });

  testWidgets('Should reject invalid characters in expression', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    await tester.enterText(find.widgetWithText(TextField, 'Formula Title'), 'Valid Title');
    await tester.enterText(find.widgetWithText(TextField, 'Variables (comma separated)'), 'x');
    await tester.enterText(find.widgetWithText(TextField, 'Equation'), 'x + #');

    await tester.tap(find.text('Save Formula'));
    await tester.pumpAndSettle();

    expect(find.text('Expression contains invalid characters'), findsOneWidget);
  });

  testWidgets('Should reject too many variables', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    await tester.enterText(find.widgetWithText(TextField, 'Formula Title'), 'Valid Title');
    await tester.enterText(find.widgetWithText(TextField, 'Variables (comma separated)'), 'v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11');
    await tester.enterText(find.widgetWithText(TextField, 'Equation'), 'v1 + 1');

    await tester.tap(find.text('Save Formula'));
    await tester.pumpAndSettle();

    expect(find.text('Too many variables (max 10)'), findsOneWidget);
  });

  testWidgets('Should reject invalid variable names', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    await tester.enterText(find.widgetWithText(TextField, 'Formula Title'), 'Valid Title');
    await tester.enterText(find.widgetWithText(TextField, 'Variables (comma separated)'), '1v');
    await tester.enterText(find.widgetWithText(TextField, 'Equation'), 'v1 + 1');

    await tester.tap(find.text('Save Formula'));
    await tester.pumpAndSettle();

    expect(find.text('Invalid variable name: 1v'), findsOneWidget);
  });

  testWidgets('Should reject overly long variable names', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    await tester.enterText(find.widgetWithText(TextField, 'Formula Title'), 'Valid Title');
    await tester.enterText(find.widgetWithText(TextField, 'Variables (comma separated)'), 'v' * 21);
    await tester.enterText(find.widgetWithText(TextField, 'Equation'), 'x + 1');

    await tester.tap(find.text('Save Formula'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Variable name too long'), findsOneWidget);
  });

  testWidgets('Should accept valid input', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    await tester.enterText(find.widgetWithText(TextField, 'Formula Title'), 'Valid Title');
    await tester.enterText(find.widgetWithText(TextField, 'Variables (comma separated)'), 'x, y');
    await tester.enterText(find.widgetWithText(TextField, 'Equation'), 'x + y * 2');

    await tester.tap(find.text('Save Formula'));
    await tester.pumpAndSettle();

    // If valid, it should attempt to pop or save. We expect no error snackbar.
    expect(find.textContaining('too long'), findsNothing);
    expect(find.text('Expression contains invalid characters'), findsNothing);
    expect(find.text('Too many variables (max 10)'), findsNothing);
  });
}
