import 'package:shared_preferences/shared_preferences.dart';

class ScoreManager {
  static const String _scoreKey = 'user_total_score';

  static Future<int> getScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_scoreKey) ?? 0;
  }

  static Future<void> addScore(int points) async {
    final prefs = await SharedPreferences.getInstance();
    int currentScore = prefs.getInt(_scoreKey) ?? 0;
    await prefs.setInt(_scoreKey, currentScore + points);
  }
}
