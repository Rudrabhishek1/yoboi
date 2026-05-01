import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:math';

import 'vocabulary_list.dart';

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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blueAccent),
          bodyLarge: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 20),
        ),
      ),
      home: const VocabHomePage(),
    );
  }
}

class VocabHomePage extends StatefulWidget {
  const VocabHomePage({Key? key}) : super(key: key);

  @override
  _VocabHomePageState createState() => _VocabHomePageState();
}

class _VocabHomePageState extends State<VocabHomePage> {
  VocabWord? _currentWord;
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadDailyWord();
    _loadBannerAd();
  }

  Future<void> _loadDailyWord() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now();
    final todayString = "${today.year}-${today.month}-${today.day}";

    final lastSavedDate = prefs.getString('lastSavedDate');
    int wordIndex;

    if (lastSavedDate == todayString) {
      // Load the already selected word for today
      wordIndex = prefs.getInt('currentWordIndex') ?? 0;
    } else {
      // Pick a new word (either random or sequential; we use random for variation)
      final random = Random();
      wordIndex = random.nextInt(vocabularyList.length);

      // Save for today
      await prefs.setString('lastSavedDate', todayString);
      await prefs.setInt('currentWordIndex', wordIndex);
    }

    setState(() {
      _currentWord = vocabularyList[wordIndex];
    });
  }

  void _loadBannerAd() {
    // Note: This is a test ad unit ID. Replace with your actual Ad unit ID for production.
    final String adUnitId = 'ca-app-pub-3940256099942544/6300978111'; // Android test banner ad unit ID

    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Ad failed to load: $error');
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word of the Day'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _currentWord == null
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            _currentWord!.word,
                            style: Theme.of(context).textTheme.displayLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _currentWord!.definition,
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Example:',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '"${_currentWord!.example}"',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
            ),
            if (_isAdLoaded && _bannerAd != null)
              Container(
                alignment: Alignment.center,
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
          ],
        ),
      ),
    );
  }
}
