typedef FormulaCalculation = double Function(List<double> inputs);

class Formula {
  final String id;
  final String title;
  final String category;
  final List<String> inputLabels;
  final List<String> inputUnits;
  final String resultUnit;
  final FormulaCalculation calculate;
  final bool isPro;

  Formula({
    required this.id,
    required this.title,
    required this.category,
    required this.inputLabels,
    required this.inputUnits,
    required this.resultUnit,
    required this.calculate,
    this.isPro = false,
  }) : assert(
         inputLabels.length == inputUnits.length,
         'Labels and Units must have same length',
       );
}
