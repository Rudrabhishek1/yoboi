import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:engineers_mate/core/providers/favorites_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FavoritesNotifier Performance', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    test('Benchmark toggleFavorite', () async {
      final container = ProviderContainer();
      final notifier = container.read(favoritesProvider.notifier);

      // Warm up
      await container.read(favoritesProvider.future);

      final stopwatch = Stopwatch()..start();
      const iterations = 1000;
      for (int i = 0; i < iterations; i++) {
        await notifier.toggleFavorite('formula_$i');
      }
      stopwatch.stop();

      print('ToggleFavorite benchmark ($iterations iterations): ${stopwatch.elapsedMicroseconds / iterations} us/op');
    });
  });
}
