import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:engineers_mate/features/electrical/resistor_color_code_screen.dart';

void main() {
  testWidgets('Resistor Color Code calculates correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: ResistorColorCodeScreen()));

    // Initial State: Brown (1), Black (0), Red (x100) -> 10 * 100 = 1000 = 1.00 kΩ
    expect(find.text('1.00 kΩ'), findsOneWidget);
    expect(find.text('±5%'), findsOneWidget); // Gold default

    // Change Band 1 to Red (2)
    // Find the selector for Band 1 (first row of colors).
    // We can tap the 3rd color (index 2, Red) in the first ListView.
    // The Finder needs to be specific.

    // Let's tap the Text "Red"? No, the list shows colors.
    // The text labels "Band 1", "Band 2" exist.

    // We can simulate state change by finding the InkWell/GestureDetector.
    // There are many. Let's look for the one corresponding to Red in Band 1.
    // This is tricky with finding by widget.

    // Alternative: We can verify the UI structure exists.
    expect(find.text('Band 1'), findsOneWidget);
    expect(find.text('Multiplier'), findsOneWidget);

    // Let's try to tap the first color of Band 1 (Black, index 0).
    // The first ListView corresponds to Band 1.
    final band1Black = find.descendant(
      of: find.widgetWithText(Row, "Band 1"),
      matching: find.byType(GestureDetector).first,
    );

    await tester.tap(band1Black);
    await tester.pump();

    // Now: Black (0), Black (0), Red (x100) -> 0 * 100 = 0
    expect(find.text('0 Ω'), findsOneWidget);
  });
}
