import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:math';

import 'vocabulary_list.dart';

class DailyWordPage extends StatefulWidget {
  const DailyWordPage({Key? key}) : super(key: key);

  @override
  _DailyWordPageState createState() => _DailyWordPageState();
}

class _DailyWordPageState extends State<DailyWordPage> {
  VocabWord? _currentWord;
  BannerAd? _bottomBannerAd;
  BannerAd? _topBannerAd;
  bool _isBottomAdLoaded = false;
  bool _isTopAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadDailyWord();
    _loadBottomBannerAd();
    _loadTopBannerAd();
  }

  Future<void> _loadDailyWord() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now();
    final todayString = "${today.year}-${today.month}-${today.day}";

    final lastSavedDate = prefs.getString('lastSavedDate');
    int wordIndex;

    if (lastSavedDate == todayString) {
      wordIndex = prefs.getInt('currentWordIndex') ?? 0;
    } else {
      final random = Random();
      wordIndex = random.nextInt(vocabularyList.length);

      await prefs.setString('lastSavedDate', todayString);
      await prefs.setInt('currentWordIndex', wordIndex);
    }

    setState(() {
      _currentWord = vocabularyList[wordIndex];
    });
  }

  void _loadBottomBannerAd() {
    final String adUnitId = 'ca-app-pub-3940256099942544/6300978111';

    _bottomBannerAd = BannerAd(
      adUnitId: adUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBottomAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  void _loadTopBannerAd() {
    final String adUnitId = 'ca-app-pub-3940256099942544/6300978111';

    _topBannerAd = BannerAd(
      adUnitId: adUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isTopAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bottomBannerAd?.dispose();
    _topBannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_isTopAdLoaded && _topBannerAd != null)
          Container(
            alignment: Alignment.center,
            width: _topBannerAd!.size.width.toDouble(),
            height: _topBannerAd!.size.height.toDouble(),
            child: AdWidget(ad: _topBannerAd!),
          ),
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
                      Card(
                        elevation: 4.0,
                        color: Colors.deepPurple.withValues(alpha: 0.1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            _currentWord!.definition,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
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
        if (_isBottomAdLoaded && _bottomBannerAd != null)
          Container(
            alignment: Alignment.center,
            width: _bottomBannerAd!.size.width.toDouble(),
            height: _bottomBannerAd!.size.height.toDouble(),
            child: AdWidget(ad: _bottomBannerAd!),
          ),
      ],
    );
  }
}
