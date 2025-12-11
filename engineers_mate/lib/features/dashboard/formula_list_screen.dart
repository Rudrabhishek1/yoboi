import 'package:flutter/material.dart';
import '../../models/formula.dart';
import '../solver/universal_solver_screen.dart';

class FormulaListScreen extends StatelessWidget {
  final String category;
  final List<Formula> formulas;

  const FormulaListScreen({
    super.key,
    required this.category,
    required this.formulas,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Hero(
              tag: 'icon_$category',
              child: const Icon(Icons.electrical_services), // Note: Ideally this icon should be passed in dynamic
            ),
            const SizedBox(width: 8),
            Text(category),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: formulas.length,
        itemBuilder: (context, index) {
          final formula = formulas[index];
          return ListTile(
            title: Text(formula.title),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UniversalSolverScreen(formula: formula),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
