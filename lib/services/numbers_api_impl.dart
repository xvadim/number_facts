import 'package:dio/dio.dart';

import 'numbers_api.dart';

class NumbersApiImpl extends NumbersApi {
  @override
  Future<NumberInfo?> loadMathFact(String? number) async {
    return _loadFact('${_number(number)}/math$_suffix');
  }

  @override
  Future<NumberInfo?> loadTriviaFact(String? number) async {
    return _loadFact('${_number(number)}/trivia$_suffix');
  }

  @override
  Future<NumberInfo?> loadDateFact(String? month, String? day) {
    final String url = month != null && day != null && day.isNotEmpty
        ? '$month/$day/date$_suffix'
        : 'random/date$_suffix';
    return _loadFact(url);
  }

  @override
  void dispose() {
    _httpClient.close();
  }

  static const String _baseUrl = 'http://numbersapi.com/';
  static const String _suffix = '?json&notfound=ceil';
  final Dio _httpClient = Dio(BaseOptions(baseUrl: _baseUrl));

  String _number(String? number) =>
      number != null && number.isNotEmpty ? number : 'random';

  Future<NumberInfo?> _loadFact(String url) async {
    NumberInfo? res;
    try {
      final Response resp = await _httpClient.get<Map<String, dynamic>>(url);
      // print('RESP ${resp.data}');
      res = NumberInfo.fromJson(resp.data as Map<String, dynamic>);
    } on DioError catch (e) {
      print('Numbers api error: $e');
    }

    return res;
  }
}
