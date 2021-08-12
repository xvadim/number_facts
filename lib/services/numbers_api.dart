class NumberInfo {
  NumberInfo(this.text, this.number);
  NumberInfo.fromJson(Map<String, dynamic> json)
      : text = json['text'] as String,
        number = json['number'];

  final String text;
  final dynamic number;
}

abstract class NumbersApi {
  /// Loads a trivia fact about a given number or random fact when number is null
  Future<NumberInfo?> loadTriviaFact(String? number);
  /// Loads a math fact about a given number or random fact when number is null
  Future<NumberInfo?> loadMathFact(String? number);
  /// Loads a fact about a given date or random fact when date is null
  /// [date] must be in the format 'mm/dd'
  Future<NumberInfo?> loadDateFact(String? date);
  /// Cleanups used resources
  void dispose();
}
