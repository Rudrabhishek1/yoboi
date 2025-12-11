import 'package:flutter/material.dart';
import '../../core/data/electrical_formulas.dart';
import 'formula_list_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Engineer's Mate"),
              background: Placeholder(), // TODO: Add nice background image
            ),
          ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          if (title == 'Electrical') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormulaListScreen(
                  category: 'Electrical',
                  formulas: electricalFormulas,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Module coming soon!')),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.7),
                color,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'icon_$title',
                child: Icon(
                  icon,
                  size: 48,
                  color: Colors.white,
                ),
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
