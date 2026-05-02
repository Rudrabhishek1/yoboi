import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:engineers_mate/core/providers/favorites_provider.dart';

void main() {
  group('FavoritesNotifier', () {
    test('initializes with empty list when no favorites saved', () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();

      final favorites = await container.read(favoritesProvider.future);
      expect(favorites, isEmpty);
    });

    test('initializes with saved favorites from SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({
        'favorite_formulas': ['id1', 'id2'],
      });
      final container = ProviderContainer();

      final favorites = await container.read(favoritesProvider.future);
      expect(favorites, ['id1', 'id2']);
    });

    test('toggleFavorite adds a formula ID if not present', () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();

      // Ensure it's loaded
      await container.read(favoritesProvider.future);

      await container.read(favoritesProvider.notifier).toggleFavorite('id1');

      final favorites = container.read(favoritesProvider).value;
      expect(favorites, ['id1']);

      // Verify persistence
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getStringList('favorite_formulas'), ['id1']);
    });

    test('toggleFavorite removes a formula ID if already present', () async {
      SharedPreferences.setMockInitialValues({
        'favorite_formulas': ['id1', 'id2'],
      });
      final container = ProviderContainer();

      await container.read(favoritesProvider.future);

      await container.read(favoritesProvider.notifier).toggleFavorite('id1');

      final favorites = container.read(favoritesProvider).value;
      expect(favorites, ['id2']);

      // Verify persistence
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getStringList('favorite_formulas'), ['id2']);
    });

    test('toggleFavorite maintains other items when removing', () async {
      SharedPreferences.setMockInitialValues({
        'favorite_formulas': ['id1', 'id2', 'id3'],
      });
      final container = ProviderContainer();

      await container.read(favoritesProvider.future);

      await container.read(favoritesProvider.notifier).toggleFavorite('id2');

      final favorites = container.read(favoritesProvider).value;
      expect(favorites, ['id1', 'id3']);
    });
  });
}
