import '../../models/formula.dart';

final List<Formula> electricalFormulas = [
  Formula(
    id: 'ohms_law_v',
    title: 'Ohm\'s Law (Find V)',
    category: 'Electrical',
    inputLabels: ['Current (I)', 'Resistance (R)'],
    inputUnits: ['A', 'Ω'],
    resultUnit: 'V',
    calculate: (inputs) => inputs[0] * inputs[1],
  ),
  Formula(
    id: 'ohms_law_i',
    title: 'Ohm\'s Law (Find I)',
    category: 'Electrical',
    inputLabels: ['Voltage (V)', 'Resistance (R)'],
    inputUnits: ['V', 'Ω'],
    resultUnit: 'A',
    calculate: (inputs) => inputs[0] / inputs[1],
  ),
  Formula(
    id: 'ohms_law_r',
    title: 'Ohm\'s Law (Find R)',
    category: 'Electrical',
    inputLabels: ['Voltage (V)', 'Current (I)'],
    inputUnits: ['V', 'A'],
    resultUnit: 'Ω',
    calculate: (inputs) => inputs[0] / inputs[1],
  ),
  Formula(
    id: 'power_dc',
    title: 'DC Power',
    category: 'Electrical',
    inputLabels: ['Voltage (V)', 'Current (I)'],
    inputUnits: ['V', 'A'],
    resultUnit: 'W',
    calculate: (inputs) => inputs[0] * inputs[1],
  ),
];
