import 'package:flutter/material.dart';

class AdBanner extends StatefulWidget {
  const AdBanner({super.key});

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
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
