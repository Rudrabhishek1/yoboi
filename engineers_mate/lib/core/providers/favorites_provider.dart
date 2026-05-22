import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final favoritesProvider =
    AsyncNotifierProvider<FavoritesNotifier, List<String>>(
      FavoritesNotifier.new,
    );

class FavoritesNotifier extends AsyncNotifier<List<String>> {
  static const String _key = 'favorite_formulas';

  @override
  Future<List<String>> build() async {
    return _loadFavorites();
  }

  Future<List<String>> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  Future<void> toggleFavorite(String formulaId) async {
    final prefs = await SharedPreferences.getInstance();
    final currentList = state.value ?? [];

    List<String> newList;
    if (currentList.contains(formulaId)) {
      newList = [...currentList]..remove(formulaId);
    } else {
      newList = [...currentList, formulaId];
    }

    await prefs.setStringList(_key, newList);
    state = AsyncData(newList);
  }
}
