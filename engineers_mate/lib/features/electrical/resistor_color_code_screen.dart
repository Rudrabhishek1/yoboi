import 'dart:math' as math;
import 'package:flutter/material.dart';

class ResistorColorCodeScreen extends StatefulWidget {
  const ResistorColorCodeScreen({super.key});

  @override
  State<ResistorColorCodeScreen> createState() => _ResistorColorCodeScreenState();
}

class _ResistorColorCodeScreenState extends State<ResistorColorCodeScreen> {
  // 0: Black, 1: Brown, 2: Red, 3: Orange, 4: Yellow,
  // 5: Green, 6: Blue, 7: Violet, 8: Grey, 9: White
  // Multipliers follow same pattern (10^color)
  // Tolerance: Brown(1%), Red(2%), Gold(5%), Silver(10%)

  final List<Color> _bandColors = [
    Colors.black, Colors.brown, Colors.red, Colors.orange, Colors.yellow,
    Colors.green, Colors.blue, Colors.purple, Colors.grey, Colors.white
  ];

  int _band1 = 1; // Brown
  int _band2 = 0; // Black
  int _multiplier = 2; // Red (x100) -> 1k Ohm
  int _toleranceIndex = 2; // Gold

  final List<Color> _toleranceColors = [Colors.brown, Colors.red, const Color(0xFFFFD700), const Color(0xFFC0C0C0)];
  final List<num> _toleranceValues = [1, 2, 5, 10];

  double get _resistance {
    int digits = _band1 * 10 + _band2;
    // Multiplier is 10^index
    // But wait, Gold/Silver multipliers exist (-1, -2).
    // For simplicity, let's stick to the 10 basic colors for multiplier for now, or add Gold/Silver if needed.
    // Standard 4-band usually uses standard colors for multiplier.
    // let's assume standard colors for multiplier (0-9).
    return digits * math.pow(10, _multiplier).toDouble();
  }

  String _formatResistance(double value) {
    if (value >= 1000000) {
      return "${(value / 1000000).toStringAsFixed(2)} MΩ";
    } else if (value >= 1000) {
      return "${(value / 1000).toStringAsFixed(2)} kΩ";
    } else {
      return "${value.toStringAsFixed(0)} Ω";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Resistor Color Code")),
      body: Column(
        children: [
          // Resistor Visual
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: Container(
                width: 300,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFD2B48C), // Tan color body
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Colors.black26, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBand(_bandColors[_band1]),
                    _buildBand(_bandColors[_band2]),
                    _buildBand(_bandColors[_multiplier]),
                    _buildBand(_toleranceColors[_toleranceIndex], spacing: true),
                  ],
                ),
              ),
            ),
          ),

          Text(
            _formatResistance(_resistance),
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Text(
            "±${_toleranceValues[_toleranceIndex]}%",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey),
          ),

          const Divider(height: 40),

          // Selectors
          Expanded(
            child: ListView(
              children: [
                _buildSelector("Band 1", _band1, _bandColors, (v) => setState(() => _band1 = v)),
                _buildSelector("Band 2", _band2, _bandColors, (v) => setState(() => _band2 = v)),
                _buildSelector("Multiplier", _multiplier, _bandColors,
                    (v) => setState(() => _multiplier = v)),
                _buildSelector("Tolerance", _toleranceIndex, _toleranceColors,
                    (v) => setState(() => _toleranceIndex = v)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBand(Color color, {bool spacing = false}) {
    return Container(
      width: 15,
      height: 80,
      margin: spacing ? const EdgeInsets.only(left: 20) : null,
      color: color,
    );
  }

  Widget _buildSelector(String label, int currentValue, List<Color> colors,
      void Function(int) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  final isSelected = index == currentValue;
                  return GestureDetector(
                    onTap: () => onChanged(index),
                    child: Container(
                      width: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: colors[index],
                        border: isSelected ? Border.all(color: Colors.black, width: 3) : Border.all(color: Colors.grey),
                        shape: BoxShape.circle,
                      ),
                      child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 20) : null,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
