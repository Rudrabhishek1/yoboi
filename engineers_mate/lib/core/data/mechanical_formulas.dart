import '../../models/formula.dart';
import 'dart:math';

final List<Formula> mechanicalFormulas = [
  Formula(
    id: 'fluid_flow_rate',
    title: 'Fluid Flow Rate',
    category: 'Mechanical',
    inputLabels: ['Area (m²)', 'Velocity (m/s)'],
    inputUnits: ['m²', 'm/s'],
    resultUnit: 'm³/s',
    calculate: (inputs) => inputs[0] * inputs[1],
  ),
  Formula(
    id: 'gear_ratio',
    title: 'Gear Ratio',
    category: 'Mechanical',
    inputLabels: ['Teeth Driven (N2)', 'Teeth Driver (N1)'],
    inputUnits: ['count', 'count'],
    resultUnit: ': 1',
    calculate: (inputs) {
      if (inputs[1] == 0) return 0.0;
      return inputs[0] / inputs[1];
    },
  ),
  Formula(
    id: 'heat_transfer_conduction',
    title: 'Heat Transfer (Conduction)',
    category: 'Mechanical',
    inputLabels: ['k (W/mK)', 'Area (m²)', 'Temp Diff (K)', 'Thickness (m)'],
    inputUnits: ['W/mK', 'm²', 'K', 'm'],
    resultUnit: 'W',
    calculate: (inputs) {
      // Q = k * A * dT / d
      if (inputs[3] == 0) return 0.0;
      return (inputs[0] * inputs[1] * inputs[2]) / inputs[3];
    },
  ),
];
