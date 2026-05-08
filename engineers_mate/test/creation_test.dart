import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:engineers_mate/features/creation/formula_creation_screen.dart';
import 'package:engineers_mate/features/dashboard/dashboard_screen.dart';

void main() {
  testWidgets('Create Custom Formula flow', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: DashboardScreen()),
      ),
    );

    // 1. Tap Add Button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // 2. Fill Form
    await tester.enterText(
        find.widgetWithText(TextField, 'Formula Title'), 'Pythagoras');
    await tester.enterText(
        find.widgetWithText(TextField, 'Variables (comma separated)'), 'a, b');
    await tester.enterText(
        find.widgetWithText(TextField, 'Equation'), 'sqrt(a^2 + b^2)');

    // 3. Save
    await tester.tap(find.text('Save Formula'));
    await tester.pumpAndSettle(); // Pop back to dashboard

    // 4. Verify Custom Category appears
    expect(find.text('Custom'), findsOneWidget);

    // 5. Tap Custom Category
    // We need to scroll if the grid is long, but it's small now.
    await tester.tap(find.text('Custom'));
    await tester.pumpAndSettle();

    // 6. Verify our new formula is listed
    expect(find.text('Pythagoras'), findsOneWidget);
  });
}
