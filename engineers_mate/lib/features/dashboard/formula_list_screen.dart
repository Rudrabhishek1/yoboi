import 'package:flutter/material.dart';
import '../../models/formula.dart';
import '../solver/universal_solver_screen.dart';
import '../electrical/resistor_color_code_screen.dart';

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
      body: ListView(
        children: [
          if (category == 'Electrical')
            ListTile(
              title: const Text("Resistor Color Code"),
              leading: const Icon(Icons.palette),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ResistorColorCodeScreen()),
                );
              },
            ),
          ...formulas.map((formula) => ListTile(
            title: Text(formula.title),
            trailing: formula.isPro
                ? const Icon(Icons.lock, color: Colors.orange)
                : const Icon(Icons.arrow_forward_ios),
            onTap: () {
              if (formula.isPro) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Pro Feature"),
                    content: const Text("Watch a short video to unlock this formula for 24 hours?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel")
                      ),
                      FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Mock "Ad Watched" success
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UniversalSolverScreen(formula: formula),
                            ),
                          );
                        },
                        child: const Text("Watch Ad"),
                      ),
                    ],
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UniversalSolverScreen(formula: formula),
                  ),
                );
              }
            },
          )),
        ],
      ),
    );
  }
}
