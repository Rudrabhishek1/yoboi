import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/formula.dart';
import '../../core/providers/history_provider.dart';

class UniversalSolverScreen extends ConsumerStatefulWidget {
  final Formula formula;

  const UniversalSolverScreen({super.key, required this.formula});

  @override
  ConsumerState<UniversalSolverScreen> createState() => _UniversalSolverScreenState();
}

class _UniversalSolverScreenState extends ConsumerState<UniversalSolverScreen> {
  late List<TextEditingController> _controllers;
  double? _result;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.formula.inputLabels.length,
      (index) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _calculate() {
    final inputs = <double>[];
    for (var controller in _controllers) {
      final value = double.tryParse(controller.text);
      if (value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter valid numbers')),
        );
        return;
      }
      inputs.add(value);
    }

    setState(() {
      _result = widget.formula.calculate(inputs);
    });

    // Save to history
    ref.read(historyProvider.notifier).addToHistory(
      widget.formula.title,
      "${_result!.toStringAsFixed(2)} ${widget.formula.resultUnit}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.formula.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: widget.formula.inputLabels.length,
                separatorBuilder: (ctx, i) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return TextField(
                    controller: _controllers[index],
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: widget.formula.inputLabels[index],
                      suffixText: widget.formula.inputUnits[index],
                      border: const OutlineInputBorder(),
                    ),
                  );
                },
              ),
            ),
            if (_result != null)
              Card(
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Result",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            "${_result!.toStringAsFixed(2)} ${widget.formula.resultUnit}",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: _calculate,
                child: const Text("Calculate"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
