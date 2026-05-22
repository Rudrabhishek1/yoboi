import '../../models/formula.dart';

final List<Formula> civilFormulas = [
  Formula(
    id: 'concrete_slab_volume',
    title: 'Concrete Slab Volume',
    category: 'Civil',
    inputLabels: ['Length (m)', 'Width (m)', 'Thickness (m)'],
    inputUnits: ['m', 'm', 'm'],
    resultUnit: 'm³',
    calculate: (inputs) => inputs[0] * inputs[1] * inputs[2],
  ),
  Formula(
    id: 'bricks_estimator',
    title: 'Brick Wall Estimator',
    category: 'Civil',
    inputLabels: [
      'Wall Length (m)',
      'Wall Height (m)',
      'Brick Length (mm)',
      'Brick Height (mm)',
    ],
    inputUnits: ['m', 'm', 'mm', 'mm'],
    resultUnit: 'bricks',
    calculate: (inputs) {
      // Inputs: 0:L, 1:H, 2:bl, 3:bh
      // Convert brick mm to m
      double brickL = inputs[2] / 1000.0;
      double brickH = inputs[3] / 1000.0;
      // Add mortar gap (approx 10mm = 0.01m)
      double mortar = 0.01;

      double wallArea = inputs[0] * inputs[1];
      double brickArea = (brickL + mortar) * (brickH + mortar);

      return wallArea / brickArea;
    },
  ),
  Formula(
    id: 'steel_weight',
    title: 'Steel Bar Weight',
    category: 'Civil',
    inputLabels: ['Diameter (mm)', 'Length (m)'],
    inputUnits: ['mm', 'm'],
    resultUnit: 'kg',
    calculate: (inputs) {
      // D^2 / 162 * L (Standard formula for steel weight in kg)
      return (inputs[0] * inputs[0] / 162.0) * inputs[1];
    },
    isPro: true, // Example of Pro Feature
  ),
];
