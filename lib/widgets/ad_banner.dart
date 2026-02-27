import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBanner extends StatefulWidget {
  const AdBanner({super.key});

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  BannerAd? _bannerAd;
  bool _failed = false;

  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      _bannerAd = BannerAd(
        adUnitId: 'ca-app-pub-6805866923030446/8736996566', // banner test
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            print("✅ Ad loaded successfully");
            setState(() {});
          },
          onAdFailedToLoad: (ad, error) {
            print("❌ Ad failed to load: ${error.code} - ${error.message}");
            ad.dispose();
            setState(() {
              _failed = true; // fallback la placeholder
            });
          },
        ),
      )..load();
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Web sau fallback pe device
    if (kIsWeb || _failed || _bannerAd == null) {
      return Container(
        height: 60,
        color: Colors.grey[800],
        child: const Center(
            child: Text(
          "Ad Placeholder",
          style: TextStyle(color: Colors.white),
        )),
      );
    } else {
      // Banner real pe Android/iOS
      return SizedBox(
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      );
    }
  }
}