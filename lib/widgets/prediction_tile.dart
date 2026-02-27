import 'package:flutter/material.dart';
import '../models/prediction.dart';

class PredictionTile extends StatelessWidget {
  final Prediction p;
  const PredictionTile(this.p, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Match
          Expanded(
            flex: 3,
            child: Text(
              p.match,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),

          // Prediction
          Expanded(
            flex: 2,
            child: Text(
              p.prediction,
              style: const TextStyle(color: Colors.white),
            ),
          ),

          // Stake
          Expanded(
            flex: 1,
            child: Text(
              "${p.stake.toStringAsFixed(0)} \$",
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.right,
            ),
          ),

          // Odd
          Expanded(
            flex: 1,
            child: Text(
              p.odd.toStringAsFixed(2),
              style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}