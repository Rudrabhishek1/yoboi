import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/formulas_provider.dart';
import '../../models/formula.dart';
import '../converter/quick_convert_screen.dart';
import '../history/history_screen.dart';
import '../ads/ad_banner.dart';
import 'formula_list_screen.dart';
import '../solver/universal_solver_screen.dart';
import '../creation/formula_creation_screen.dart';
import '../../core/ui/blueprint_background.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<Formula> _searchResults = [];

  void _runSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final allFormulas = ref.read(formulasProvider);
    setState(() {
      _searchResults = allFormulas
          .where((f) => f.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AdBanner(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: _isSearching
                  ? TextField(
                      controller: _searchController,
                      autofocus: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Search formulas...",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                      onChanged: _runSearch,
                    )
                  : const Text("Engineer's Mate"),
              background: const BlueprintBackground(),
            ),
            actions: [
              IconButton(
                icon: Icon(_isSearching ? Icons.close : Icons.search),
                tooltip: _isSearching ? 'Close search' : 'Search formulas',
                onPressed: () {
                  setState(() {
                    _isSearching = !_isSearching;
                    if (!_isSearching) {
                      _searchController.clear();
                      _searchResults = [];
                    }
                  });
                },
              ),
              if (!_isSearching) ...[
                IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: 'Create new formula',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FormulaCreationScreen(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.history),
                  tooltip: 'View history',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HistoryScreen(),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
          if (_isSearching)
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final formula = _searchResults[index];
                return ListTile(
                  title: Text(formula.title),
                  subtitle: Text(formula.category),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UniversalSolverScreen(formula: formula),
                      ),
                    );
                  },
                );
              }, childCount: _searchResults.length),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                children: const [
                  CategoryCard(
                    title: 'Electrical',
                    icon: Icons.electrical_services,
                    color: Colors.amber,
                  ),
                  CategoryCard(
                    title: 'Civil',
                    icon: Icons.foundation,
                    color: Colors.blueGrey,
                  ),
                  CategoryCard(
                    title: 'Mechanical',
                    icon: Icons.settings,
                    color: Colors.orange,
                  ),
                  CategoryCard(
                    title: 'Quick Convert',
                    icon: Icons.swap_horiz,
                    color: Colors.green,
                  ),
                  CategoryCard(
                    title: 'Custom',
                    icon: Icons.edit_note,
                    color: Colors.purple,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class CategoryCard extends ConsumerWidget {
  final String title;
  final IconData icon;
  final Color color;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          if (title == 'Electrical') {
            final formulas = ref.read(formulasByCategoryProvider('Electrical'));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormulaListScreen(
                  category: 'Electrical',
                  formulas: formulas,
                ),
              ),
            );
          } else if (title == 'Civil') {
            final formulas = ref.read(formulasByCategoryProvider('Civil'));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FormulaListScreen(category: 'Civil', formulas: formulas),
              ),
            );
          } else if (title == 'Mechanical') {
            final formulas = ref.read(formulasByCategoryProvider('Mechanical'));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormulaListScreen(
                  category: 'Mechanical',
                  formulas: formulas,
                ),
              ),
            );
          } else if (title == 'Quick Convert') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QuickConvertScreen(),
              ),
            );
          } else if (title == 'Custom') {
            final formulas = ref.read(formulasByCategoryProvider('Custom'));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FormulaListScreen(category: 'Custom', formulas: formulas),
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.7), color],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'icon_$title',
                child: Icon(icon, size: 48, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
