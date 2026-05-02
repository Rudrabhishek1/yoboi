import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'daily_word_page.dart';
import 'quiz_page.dart';
import 'scoreboard_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const DailyVocabApp());
}

class DailyVocabApp extends StatelessWidget {
  const DailyVocabApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Vocab Builder',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.w800, color: Colors.deepPurpleAccent),
          bodyLarge: TextStyle(fontSize: 22, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(fontSize: 20),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DailyWordPage(),
    const QuizPage(),
    const ScoreboardPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Vocab Builder'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Daily Word',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Scoreboard',
          ),
        ],
      ),
    );
  }
}
