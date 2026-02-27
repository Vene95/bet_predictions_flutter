import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdManager {
  InterstitialAd? _interstitialAd;
  bool _isLoaded = false;

  void loadAd() {
    if (kIsWeb) return;

    InterstitialAd.load(
      adUnitId: 'ca-app-pub-6805866923030446/7077594257', // test interstitial
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          print("✅ Interstitial loaded");
          _interstitialAd = ad;
          _isLoaded = true;
          _interstitialAd?.setImmersiveMode(true);
        },
        onAdFailedToLoad: (error) {
          print("❌ Interstitial failed: ${error.code} - ${error.message}");
          _isLoaded = false;
        },
      ),
    );
  }

  /// Folosește acest showAd cu callback onAdClosed pentru navigare după ce ad-ul se închide
  void showAd({required VoidCallback onAdClosed}) {
    if (_isLoaded && _interstitialAd != null) {
      _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          loadAd(); // reload
          onAdClosed();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          loadAd();
          onAdClosed();
        },
      );
      _interstitialAd?.show();
      _interstitialAd = null;
      _isLoaded = false;
    } else {
      print("Interstitial not ready, using fallback");
      onAdClosed(); // fallback imediat
    }
  }
}