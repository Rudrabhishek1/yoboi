import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:engineers_mate/features/converter/quick_convert_screen.dart';

void main() {
  testWidgets('Quick Convert Screen renders and converts Length', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: QuickConvertScreen()));

    // Check initial state (Length selected by default)
    expect(find.text('Length'), findsOneWidget);
    expect(find.text('Mass'), findsOneWidget);
    expect(find.text('Temperature'), findsOneWidget);

    // Pump to allow initial conversion to happen
    await tester.pumpAndSettle();

    // Verify initial conversion (Meters to Kilometers by default)
    // 1 meter = 0.001 km
    expect(find.text('0.0010'), findsOneWidget);

    // Enter new value
    await tester.enterText(find.byType(TextField), '2000');
    await tester.pump();

    // 2000 meters = 2.0000 km
    expect(find.text('2.0000'), findsOneWidget);
  });

  testWidgets('Quick Convert switches categories', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: QuickConvertScreen()));

    // Tap Mass
    await tester.tap(find.text('Mass'));
    await tester.pumpAndSettle();

    // Default Mass is kg -> g? or similar. Let's check logic by finding the dropdowns
    // Initial Mass defaults in code: _units[1] = [kilograms, grams...]
    // _fromUnit = kilograms, _toUnit = grams
    // 1 kg = 1000 g
    expect(find.text('1000.0000'), findsOneWidget);
  });

  testWidgets('Quick Convert switches to Temperature category correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: QuickConvertScreen()));

    // Wait for initial frame setup
    await tester.pumpAndSettle();

    // Tap Temperature
    await tester.tap(find.text('Temperature'));
    await tester.pumpAndSettle();

    // Default Temperature is Celsius -> Fahrenheit.
    // _units[2] = [TEMPERATURE.celsius, TEMPERATURE.fahrenheit, TEMPERATURE.kelvin]
    // _fromUnit = TEMPERATURE.celsius, _toUnit = TEMPERATURE.fahrenheit
    // The codebase uses 2 decimal places for Temperature: toStringAsFixed(2)
    // 1 C = 33.80 F
    expect(find.text('33.80'), findsOneWidget);

    // Verify UI dropdowns have been updated with Temperature specific units
    // In Dart enums, unit.name returns the string name of the enum value.
    expect(find.text('celsius'), findsWidgets);
    expect(find.text('fahrenheit'), findsWidgets);
  });
}
