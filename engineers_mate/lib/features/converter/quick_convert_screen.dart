import 'package:flutter/material.dart';
import 'package:units_converter/units_converter.dart';

class QuickConvertScreen extends StatefulWidget {
  const QuickConvertScreen({super.key});

  @override
  State<QuickConvertScreen> createState() => _QuickConvertScreenState();
}

class _QuickConvertScreenState extends State<QuickConvertScreen> {
  int _selectedCategoryIndex = 0; // 0: Length, 1: Mass, 2: Temperature
  double _inputValue = 1.0;

  // Controllers for the input field
  final TextEditingController _inputController = TextEditingController(
    text: '1.0',
  );

  // Definitions for our conversions
  final List<String> _categories = ['Length', 'Mass', 'Temperature'];

  // Units to display for each category
  final Map<int, List<Enum>> _units = {
    0: [
      LENGTH.meters,
      LENGTH.kilometers,
      LENGTH.centimeters,
      LENGTH.millimeters,
      LENGTH.miles,
      LENGTH.yards,
      LENGTH.feet,
      LENGTH.inches,
    ],
    1: [MASS.kilograms, MASS.grams, MASS.pounds, MASS.ounces, MASS.tons],
    2: [TEMPERATURE.celsius, TEMPERATURE.fahrenheit, TEMPERATURE.kelvin],
  };

  Enum _fromUnit = LENGTH.meters;
  Enum _toUnit = LENGTH.feet;

  @override
  void initState() {
    super.initState();
    // Initialize defaults
    _selectedCategoryIndex = 0;
    _fromUnit = _units[0]![0];
    _toUnit = _units[0]![1];
    // Defer conversion to build frame or ensure it runs once
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _convert();
    });
  }

  void _updateUnitsForCategory(int index) {
    setState(() {
      _selectedCategoryIndex = index;
      _fromUnit = _units[index]![0];
      _toUnit = _units[index]![1];
      _convert();
    });
  }

  String _result = "";

  void _convert() {
    if (_selectedCategoryIndex == 0) {
      // Length
      var input = _inputValue.convertFromTo(
        _fromUnit as LENGTH,
        _toUnit as LENGTH,
      );
      debugPrint(
        "Converting Length: $_inputValue from $_fromUnit to $_toUnit = $input",
      );
      _result = input?.toStringAsFixed(4) ?? "Error";
    } else if (_selectedCategoryIndex == 1) {
      // Mass
      var input = _inputValue.convertFromTo(_fromUnit as MASS, _toUnit as MASS);
      _result = input?.toStringAsFixed(4) ?? "Error";
    } else if (_selectedCategoryIndex == 2) {
      // Temperature
      var input = _inputValue.convertFromTo(
        _fromUnit as TEMPERATURE,
        _toUnit as TEMPERATURE,
      );
      _result = input?.toStringAsFixed(2) ?? "Error";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quick Convert")),
      body: Column(
        children: [
          // Category Selector
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: List.generate(_categories.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(_categories[index]),
                    selected: _selectedCategoryIndex == index,
                    onSelected: (bool selected) {
                      if (selected) {
                        _updateUnitsForCategory(index);
                      }
                    },
                  ),
                );
              }),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Input
                  TextField(
                    controller: _inputController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: "Value",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _inputValue = double.tryParse(value) ?? 0.0;
                        _convert();
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // From Unit
                  Row(
                    children: [
                      const Expanded(child: Text("From:")),
                      DropdownButton<Enum>(
                        value: _fromUnit,
                        items: _units[_selectedCategoryIndex]!.map((Enum unit) {
                          return DropdownMenuItem<Enum>(
                            value: unit,
                            child: Text(unit.name),
                          );
                        }).toList(),
                        onChanged: (Enum? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _fromUnit = newValue;
                              _convert();
                            });
                          }
                        },
                      ),
                    ],
                  ),

                  const Icon(Icons.arrow_downward),

                  // To Unit
                  Row(
                    children: [
                      const Expanded(child: Text("To:")),
                      DropdownButton<Enum>(
                        value: _toUnit,
                        items: _units[_selectedCategoryIndex]!.map((Enum unit) {
                          return DropdownMenuItem<Enum>(
                            value: unit,
                            child: Text(unit.name),
                          );
                        }).toList(),
                        onChanged: (Enum? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _toUnit = newValue;
                              _convert();
                            });
                          }
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Result
                  Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Text(
                            "Result",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            _result,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
