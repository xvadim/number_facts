class NumberInfo {
  NumberInfo(this.text, this.number);
  NumberInfo.fromJson(Map<String, dynamic> json)
      : text = json['text'] as String,
        number = json['number'];

  final String text;
  final dynamic number;
}

abstract class NumbersApi {
  Future<NumberInfo?> loadTriviaFact(String? number);
  Future<NumberInfo?> loadMathFact(String? number);
  Future<NumberInfo?> loadDateFact(String? month, String? day);
  void dispose();
}
