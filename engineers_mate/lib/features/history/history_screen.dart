import 'package:flutter/material.dart';
import '../../core/services/history_service.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
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
                 await HistoryService().clearHistory();
                 // Rebuild? This is stateless. We might need a FutureBuilder or setState in parent.
                 // For now, let's just pop or force refresh if we used a StateNotifier.
                 // Ideally, we use Riverpod, but for "Easy Implementation" Phase 4, FutureBuilder works.
                 Navigator.pop(context); // Simple UX: Close screen on clear
               }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<HistoryItem>>(
        future: HistoryService().getHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No history yet"));
          }

          final history = snapshot.data!;
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
      ),
    );
  }
}
