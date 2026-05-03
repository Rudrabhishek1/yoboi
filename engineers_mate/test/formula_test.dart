import 'package:flutter_test/flutter_test.dart';
import 'package:engineers_mate/models/formula.dart';

void main() {
  group('Formula Model Tests', () {
    test('should create Formula when inputLabels and inputUnits have same length', () {
      final formula = Formula(
        id: 'test_id',
        title: 'Test Formula',
        category: 'Test Category',
        inputLabels: ['L1', 'L2'],
        inputUnits: ['U1', 'U2'],
        resultUnit: 'R',
        calculate: (inputs) => inputs[0] + inputs[1],
      );

      expect(formula.id, 'test_id');
      expect(formula.inputLabels.length, 2);
      expect(formula.inputUnits.length, 2);
    });

    test('should throw AssertionError when inputLabels and inputUnits have different lengths', () {
      expect(
        () => Formula(
          id: 'test_id',
          title: 'Test Formula',
          category: 'Test Category',
          inputLabels: ['L1', 'L2', 'L3'],
          inputUnits: ['U1', 'U2'],
          resultUnit: 'R',
          calculate: (inputs) => 0.0,
        ),
        throwsA(isA<AssertionError>().having(
          (e) => e.message,
          'message',
          'Labels and Units must have same length',
        )),
      );
    });
  });
}
