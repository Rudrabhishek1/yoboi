import 'package:flutter_test/flutter_test.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  test('Math Expressions parses variables', () {
    Parser p = Parser();
    Expression exp = p.parse('a * b + 5');

    ContextModel cm = ContextModel();
    cm.bindVariable(Variable('a'), Number(2));
    cm.bindVariable(Variable('b'), Number(3));

    // 2 * 3 + 5 = 11
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    expect(eval, 11.0);
  });

  test('Math Expressions throws on invalid', () {
    Parser p = Parser();
    expect(() => p.parse('a * +'), throwsA(anything));
  });
}
