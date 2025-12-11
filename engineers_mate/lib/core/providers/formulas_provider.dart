import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/formula.dart';
import '../data/electrical_formulas.dart';
import '../data/civil_formulas.dart';
import '../data/mechanical_formulas.dart';
import 'custom_formulas_provider.dart';

final formulasProvider = Provider<List<Formula>>((ref) {
  // Combine all static formulas
  final customFormulas = ref.watch(customFormulasProvider).valueOrNull ?? [];

  return [
    ...customFormulas.map((d) => d.toFormula()),
    ...electricalFormulas,
    ...civilFormulas,
    ...mechanicalFormulas,
  ];
});

final formulasByCategoryProvider = Provider.family<List<Formula>, String>((ref, category) {
  final allFormulas = ref.watch(formulasProvider);
  return allFormulas.where((f) => f.category == category).toList();
});
