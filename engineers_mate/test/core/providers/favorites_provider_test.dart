import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:engineers_mate/core/providers/favorites_provider.dart';

void main() {
  group('FavoritesNotifier', () {
    test('initial state is empty when no favorites are saved', () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final favorites = await container.read(favoritesProvider.future);
      expect(favorites, isEmpty);
    });

    test('initial state loads saved favorites', () async {
      SharedPreferences.setMockInitialValues({
        'favorite_formulas': ['formula_1', 'formula_2'],
      });
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final favorites = await container.read(favoritesProvider.future);
      expect(favorites, equals(['formula_1', 'formula_2']));
    });

    test('toggleFavorite adds a formula if not present', () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Wait for initial load
      await container.read(favoritesProvider.future);

      await container.read(favoritesProvider.notifier).toggleFavorite('formula_1');

      final favorites = await container.read(favoritesProvider.future);
      expect(favorites, contains('formula_1'));

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getStringList('favorite_formulas'), contains('formula_1'));
    });

    test('toggleFavorite removes a formula if already present', () async {
      SharedPreferences.setMockInitialValues({
        'favorite_formulas': ['formula_1', 'formula_2'],
      });
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Wait for initial load
      await container.read(favoritesProvider.future);

      await container.read(favoritesProvider.notifier).toggleFavorite('formula_1');

      final favorites = await container.read(favoritesProvider.future);
      expect(favorites, isNot(contains('formula_1')));
      expect(favorites, contains('formula_2'));

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getStringList('favorite_formulas'), isNot(contains('formula_1')));
      expect(prefs.getStringList('favorite_formulas'), contains('formula_2'));
    });
  });
}
