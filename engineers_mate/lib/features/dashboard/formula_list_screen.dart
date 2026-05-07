import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/formula.dart';
import '../solver/universal_solver_screen.dart';
import '../electrical/resistor_color_code_screen.dart';
import '../../core/providers/favorites_provider.dart';

class FormulaListScreen extends ConsumerWidget {
  final String category;
  final List<Formula> formulas;

  const FormulaListScreen({
    super.key,
    required this.category,
    required this.formulas,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider).valueOrNull ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Hero(
              tag: 'icon_$category',
              child: const Icon(Icons.electrical_services),
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
          ...formulas.map((formula) {
            final isFav = favorites.contains(formula.id);
            return ListTile(
            title: Text(formula.title),
            leading: IconButton(
              icon: Icon(isFav ? Icons.star : Icons.star_border, color: isFav ? Colors.amber : null),
              tooltip: isFav ? 'Remove from Favorites' : 'Add to Favorites',
              onPressed: () {
                ref.read(favoritesProvider.notifier).toggleFavorite(formula.id);
              },
            ),
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
          );
          }),
        ],
      ),
    );
  }
}
