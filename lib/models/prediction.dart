class Prediction {
  final String match;
  final String prediction;
  final double stake;
  final double odd;

  Prediction({
    required this.match,
    required this.prediction,
    required this.stake,
    required this.odd,
  });

  factory Prediction.fromJson(Map<String, dynamic> json){
    return Prediction(
      match: json['match'],
      prediction: json['prediction'],
      stake: json['stake'].toDouble(),
      odd: json['odd'].toDouble(),
    );
  }
}