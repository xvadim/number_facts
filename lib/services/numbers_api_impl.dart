import 'package:dio/dio.dart';

import 'numbers_api.dart';

class NumbersApiImpl extends NumbersApi {
  @override
  Future<NumberInfo?> loadMathFact(String? number) async =>
      _loadFact('math', number);

  @override
  Future<NumberInfo?> loadTriviaFact(String? number) async =>
      _loadFact('trivia', number);

  @override
  Future<NumberInfo?> loadDateFact(String? date) async =>
      _loadFact('date', date);

  @override
  void dispose() {
    _httpClient.close();
  }

  static const String _baseUrl = 'http://numbersapi.com/';
  static const String _suffix = '?json&notfound=ceil';

  final Dio _httpClient = Dio(BaseOptions(baseUrl: _baseUrl));

  String _number(String? number) =>
      number != null && number.isNotEmpty ? number : 'random';


  // Loads a fact about a given number
  // [kind]: 'date', 'trivia', 'math'
  // [number]: a number or null for random fact
  Future<NumberInfo?> _loadFact(String kind, String? number) async {
    final String url = '${_number(number)}/$kind$_suffix';
    NumberInfo? res;

    try {
      final Response resp = await _httpClient.get<Map<String, dynamic>>(url);
      res = NumberInfo.fromJson(resp.data as Map<String, dynamic>);
    } on DioError catch (e) {
      print('Numbers api error: $e');
    }

    return res;
  }
}
