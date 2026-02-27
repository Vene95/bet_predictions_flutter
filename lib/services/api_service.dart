import '../models/prediction.dart';

class ApiService {
  static Future<List<Prediction>> getPredictions() async {

    // simulare delay (ca la request real)
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      Prediction(match: "Barcelona vs Real Madrid", prediction: "1", stake: 100, odd: 1.1),
      Prediction(match: "Arsenal vs Chelsea", prediction: "Over 2.5", stake: 80, odd: 1.1),
      Prediction(match: "Juventus vs Milan", prediction: "X2", stake: 70, odd: 1.52),
    ];
  }
}