import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:engineers_mate/core/ui/blueprint_background.dart';

void main() {
  testWidgets('BlueprintBackground renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: BlueprintBackground(),
        ),
      ),
    );

    expect(find.byType(BlueprintBackground), findsOneWidget);

    final customPaintFinder = find.byWidgetPredicate(
      (widget) => widget is CustomPaint && widget.painter is GridPainter,
    );
    expect(customPaintFinder, findsOneWidget);

    final gridPainter = GridPainter();
    expect(gridPainter.shouldRepaint(gridPainter), isFalse);
  });

  testWidgets('BlueprintBackground golden test', (WidgetTester tester) async {
    final key = GlobalKey();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RepaintBoundary(
            key: key,
            child: const SizedBox(
              width: 400,
              height: 400,
              child: BlueprintBackground(),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byKey(key),
      matchesGoldenFile('goldens/blueprint_background.png'),
    );
  });
}
