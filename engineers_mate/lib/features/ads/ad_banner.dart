import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBanner extends StatefulWidget {
  const AdBanner({super.key});

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    // In this environment, we cannot actually load Ads.
    // So we will just simulate "Loaded" state or just do nothing if dependencies aren't set up for real execution.
    // For production code, this is how we do it:

    // _bannerAd = BannerAd(
    //   adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    //   request: const AdRequest(),
    //   size: AdSize.banner,
    //   listener: BannerAdListener(
    //     onAdLoaded: (ad) {
    //       setState(() {
    //         _isLoaded = true;
    //       });
    //     },
    //     onAdFailedToLoad: (ad, err) {
    //       ad.dispose();
    //     },
    //   ),
    // )..load();

    // For this simulation/test environment:
    setState(() {
      _isLoaded = true; // Pretend we loaded an ad
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoaded) {
       // Mock Ad Banner
       return Container(
         alignment: Alignment.center,
         width: double.infinity,
         height: 50,
         color: Colors.grey[300],
         child: const Text("AdMob Banner Placeholder"),
       );
    }
    return const SizedBox.shrink();
  }
}
