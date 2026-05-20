import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final favoritesProvider = AsyncNotifierProvider<FavoritesNotifier, List<String>>(FavoritesNotifier.new);

class FavoritesNotifier extends AsyncNotifier<List<String>> {
  static const String _key = 'favorite_formulas';
  late final SharedPreferences _prefs; // ⚡ Bolt: Cache SharedPreferences to avoid microtask overhead

  @override
  Future<List<String>> build() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getStringList(_key) ?? [];
  }

  Future<void> toggleFavorite(String formulaId) async {
    if (state is! AsyncData) await future;
    final currentList = state.value ?? [];

    List<String> newList;
    if (currentList.contains(formulaId)) {
      newList = [ ...currentList ]..remove(formulaId);
    } else {
      newList = [ ...currentList, formulaId ];
    }

    await _prefs.setStringList(_key, newList);
    state = AsyncData(newList);
  }
}
