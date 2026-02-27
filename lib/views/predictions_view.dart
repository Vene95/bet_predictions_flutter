import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/ad_banner.dart';
import '../widgets/prediction_tile.dart';

class PredictionsView extends StatefulWidget {
  const PredictionsView({super.key});

  @override
  State<PredictionsView> createState() => _PredictionsViewState();
}

class _PredictionsViewState extends State<PredictionsView> {
  List predictions = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    predictions = await ApiService.getPredictions();
    setState(() {});
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
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
          Expanded(
              flex: 2,
              child: Text("Prediction",
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
          Expanded(
              flex: 1,
              child: Text("Stake",
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right)),
          Expanded(
              flex: 1,
              child: Text("Odd",
                  style:
                      TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Predictions",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF00C853),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // ← back alb
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const AdBanner(),
          tableHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: predictions.length,
              itemBuilder: (c, i) => PredictionTile(predictions[i]),
            ),
          ),
          const AdBanner(),
        ],
      ),
    );
  }
}