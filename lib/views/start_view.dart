import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/ad_banner.dart';
import '../widgets/prediction_tile.dart';
import '../widgets/ad_interstitial.dart';
import 'predictions_view.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  List predictions = [];
  double totalOdd = 1;

  final InterstitialAdManager _interstitialManager = InterstitialAdManager();

  @override
  void initState() {
    super.initState();
    load();
    _interstitialManager.loadAd(); // preload interstitial
  }

  load() async {
    predictions = await ApiService.getPredictions();

    double t = 1;
    for (var p in predictions) {
      t *= p.odd;
      if (t >= 2) break;
    }

    setState(() {
      totalOdd = t;
    });
  }

  Widget tableHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF333333),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: const [
          Expanded(
              flex: 3,
              child: Text("Match",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))),
          Expanded(
              flex: 2,
              child: Text("Prediction",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))),
          Expanded(
              flex: 1,
              child: Text("Stake",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right)),
          Expanded(
              flex: 1,
              child: Text("Odd",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Two-Odd Prediction",
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF00C853),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          const AdBanner(), // banner sus
          const SizedBox(height: 10),
          const Text(
            "Today's Two-Odd Prediction",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          tableHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: predictions.length,
              itemBuilder: (c, i) => PredictionTile(predictions[i]),
            ),
          ),
          Text(
            "TOTAL ODDS: ${totalOdd.toStringAsFixed(2)}",
            style: const TextStyle(
                fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ElevatedButton(
              onPressed: () {
                _interstitialManager.showAd(
                  onAdClosed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PredictionsView()),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00C853),
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                "ALL PREDICTIONS",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const AdBanner(), // banner jos
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}