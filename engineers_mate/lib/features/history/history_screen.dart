import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/history_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Clear history',
            onPressed: () async {
               // Confirm dialog
               final confirm = await showDialog<bool>(
                 context: context,
                 builder: (context) => AlertDialog(
                   title: const Text("Clear History"),
                   content: const Text("Are you sure?"),
                   actions: [
                     TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
                     TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Clear")),
                   ],
                 ),
               );

               if (confirm == true) {
                 await ref.read(historyProvider.notifier).clearHistory();
                 // No need to pop, UI updates automatically
               }
            },
          ),
        ],
      ),
      body: historyAsync.when(
        data: (history) {
          if (history.isEmpty) {
            return const Center(child: Text("No history yet"));
          }
          return ListView.separated(
            itemCount: history.length,
            separatorBuilder: (ctx, i) => const Divider(),
            itemBuilder: (context, index) {
              final item = history[index];
              return ListTile(
                title: Text(item.formulaTitle),
                subtitle: Text(item.timestamp.toLocal().toString().split('.')[0]),
                trailing: Text(
                  item.result,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
