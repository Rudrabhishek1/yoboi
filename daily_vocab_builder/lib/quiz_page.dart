import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'vocabulary_list.dart';
import 'score_manager.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  VocabWord? _targetWord;
  List<String> _options = [];
  bool _answered = false;
  bool _isCorrect = false;
  String? _selectedOption;

  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
    _loadInterstitialAd();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712', // Android test interstitial ad unit ID
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _interstitialAd = null;
              _loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (error) {
          debugPrint('Interstitial ad failed to load: $error');
        },
      ),
    );
  }

  void _generateQuestion() {
    final random = Random();

    // Pick a target word
    int targetIndex = random.nextInt(vocabularyList.length);
    _targetWord = vocabularyList[targetIndex];

    // Pick 3 other random definitions
    Set<int> optionIndices = {targetIndex};
    while (optionIndices.length < 4) {
      optionIndices.add(random.nextInt(vocabularyList.length));
    }

    _options = optionIndices.map((i) => vocabularyList[i].definition).toList();
    _options.shuffle();

    setState(() {
      _answered = false;
    });
  }

  void _handleAnswer(String selectedDefinition) async {
    setState(() {
      _answered = true;
      _selectedOption = selectedDefinition;
      _isCorrect = selectedDefinition == _targetWord!.definition;
    });

    if (_isCorrect) {
      await ScoreManager.addScore(10); // Give 10 points for a correct answer
    }

    // Show Interstitial ad occasionally (e.g., 30% chance after answering)
    if (Random().nextDouble() < 0.3 && _interstitialAd != null) {
      _interstitialAd!.show();
    }
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_targetWord == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Card(
            elevation: 4.0,
            color: Colors.deepPurple.withValues(alpha: 0.05),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              child: Column(
                children: [
                  Text(
                    'What is the definition of:',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _targetWord!.word,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.deepPurple),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListView.builder(
                itemCount: _options.length,
                itemBuilder: (context, index) {
                String option = _options[index];

                Color? buttonColor;
                if (_answered) {
                  if (option == _targetWord!.definition) {
                    buttonColor = Colors.green; // Correct answer
                  } else if (_selectedOption == option) {
                     buttonColor = Colors.red.withOpacity(0.5); // Highlight the wrong option the user selected
                  }
                }

                // If answered, handle the click logic ourselves so we don't disable the button
                // which forces the default grey disabled color.
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: buttonColor ?? Colors.deepPurple.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: buttonColor != null
                        ? [BoxShadow(color: buttonColor.withValues(alpha: 0.5), blurRadius: 8, spreadRadius: 2)]
                        : [],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: _answered ? null : () => _handleAnswer(option),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 16,
                              color: buttonColor != null ? Colors.white : Colors.black87,
                              fontWeight: buttonColor != null ? FontWeight.bold : FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              ),
            ),
          ),
          if (_answered)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: _generateQuestion,
                child: const Text('Next Question'),
              ),
            )
        ],
      ),
    );
  }
}
