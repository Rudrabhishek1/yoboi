import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:engineers_mate/features/dashboard/dashboard_screen.dart';
import 'package:engineers_mate/features/dashboard/formula_list_screen.dart';
import 'package:engineers_mate/models/formula.dart';

void main() {
  testWidgets('Favorites: Toggle updates UI', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    final formula = Formula(
      id: 'test_fav',
      title: 'Test Favorite',
      category: 'Test',
      inputLabels: [],
      inputUnits: [],
      resultUnit: '',
      calculate: (i) => 0,
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: FormulaListScreen(category: 'Test', formulas: [formula]),
        ),
      ),
    );

    // Initial: Not Favorite (Border Icon)
    expect(find.byIcon(Icons.star_border), findsOneWidget);
    expect(find.byIcon(Icons.star), findsNothing);

    // Tap to favorite
    await tester.tap(find.byType(IconButton).first);
    await tester.pump(); // AsyncNotifier might need pump

    // Now: Favorite (Filled Icon)
    expect(find.byIcon(Icons.star), findsOneWidget);
  });

  testWidgets('Search: Filters dashboard', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: DashboardScreen()),
      ),
    );

    // Initial: Categories visible
    expect(find.text('Electrical'), findsOneWidget);

    // Tap Search
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // Enter "Ohm"
    await tester.enterText(find.byType(TextField), 'Ohm');
    await tester.pumpAndSettle();

    // Should see results
    expect(find.text("Ohm's Law (Find V)"), findsOneWidget);
    // Should NOT see Category Cards (Grid is replaced by List)
    expect(find.byType(CategoryCard), findsNothing);

    // Tap Result
    await tester.tap(find.text("Ohm's Law (Find V)"));
    await tester.pumpAndSettle();

    // Should be in Solver
    expect(find.text("Result"), findsNothing); // Solver screen has "Result" but only after calc.
    // Check title in AppBar
    expect(find.text("Ohm's Law (Find V)"), findsOneWidget);
  });
}
