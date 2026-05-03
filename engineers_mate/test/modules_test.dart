import 'package:flutter_test/flutter_test.dart';
import 'package:engineers_mate/core/data/civil_formulas.dart';
import 'package:engineers_mate/core/data/mechanical_formulas.dart';
import 'package:engineers_mate/core/data/electrical_formulas.dart';

void main() {
  group('Civil Formulas', () {
    test('Concrete Slab Volume', () {
      final f = civilFormulas.firstWhere((e) => e.id == 'concrete_slab_volume');
      // 10m x 5m x 0.5m = 25m3
      expect(f.calculate([10, 5, 0.5]), 25.0);
    });

    test('Steel Weight', () {
      final f = civilFormulas.firstWhere((e) => e.id == 'steel_weight');
      // D=10mm, L=1m. Weight = 10^2/162 * 1 = 100/162 = 0.617
      expect(f.calculate([10, 1]), closeTo(0.617, 0.001));
    });
  });

  group('Mechanical Formulas', () {
    test('Gear Ratio', () {
      final f = mechanicalFormulas.firstWhere((e) => e.id == 'gear_ratio');
      // Driven=100, Driver=20 -> 5
      expect(f.calculate([100, 20]), 5.0);
    });

    test('Heat Transfer', () {
      final f = mechanicalFormulas.firstWhere((e) => e.id == 'heat_transfer_conduction');
      // k=10, A=2, dT=50, d=0.1
      // Q = 10 * 2 * 50 / 0.1 = 1000 / 0.1 = 10000
      expect(f.calculate([10, 2, 50, 0.1]), 10000.0);
    });
  });

  group('Electrical Formulas', () {
    test('Ohm\'s Law (Find I)', () {
      final f = electricalFormulas.firstWhere((e) => e.id == 'ohms_law_i');
      // V=10, R=2 -> I=5
      expect(f.calculate([10, 2]), 5.0);
    });

    test('Ohm\'s Law (Find I) - Divide by Zero', () {
      final f = electricalFormulas.firstWhere((e) => e.id == 'ohms_law_i');
      // V=10, R=0 -> I=Infinity
      expect(f.calculate([10, 0]), double.infinity);
    });
  });
}
