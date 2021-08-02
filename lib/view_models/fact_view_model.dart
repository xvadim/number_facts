import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../services/numbers_api.dart';
import '../services/service_locator.dart';
import '../services/translator_api.dart';
import '../views/number_fact_view.dart';
import '../views/settings_view.dart';

class FactViewModel extends ChangeNotifier {

  FactViewModel(this._mode) {
    _loadInitFact();
  }

  Future<void> loadFact(String? number, String? month, String? lang) async {

    _curLang = lang;
    _numberFacts.clear();
    _isLoading = true;

    notifyListeners();

    await _loadFact(number, month);

    await _translateFact();

    _isLoading = false;

    notifyListeners();
  }

  Future<void> changeLang(String? lang) async {
    if (_curLang == lang) {
      return;
    }
    _curLang = lang;

    if (_numberFacts[_curLang] != null) {
      notifyListeners();
      return;
    }
    _isLoading = true;

    notifyListeners();

    await _translateFact();

    _isLoading = false;
    notifyListeners();
  }

  String get numberFact => _numberFacts[_curLang] ?? '';
  bool get isLoading => _isLoading;

  final NumberFactViewMode _mode;

  String? _curLang;
  final Map<String?, String?> _numberFacts = <String?, String?>{};
  bool _isLoading = false;

  Future<void> _loadFact(String? number1, String? month) async {
    final NumbersApi api = serviceLocator<NumbersApi>();
    NumberInfo? info;
    switch(_mode) {
      case NumberFactViewMode.trivia:
        info = await api.loadTriviaFact(number1);
        break;
      case NumberFactViewMode.dates:
        info = await api.loadDateFact(month, number1);
        break;
      default:
        info = await api.loadMathFact(number1);
    }

    _numberFacts[null] = info?.text ?? 'Not found';
  }

  Future<void> _translateFact() async {
    if (_curLang != null) {
      final TranslatorApi translatorApi = serviceLocator<TranslatorApi>();
      _numberFacts[_curLang] = await translatorApi.translate(_numberFacts[null]!, to: _curLang);
    }
  }

  Future<void> _loadInitFact() async {
    String? number;
    String? month;

    if (_mode == NumberFactViewMode.dates) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final int mode = prefs.getInt(SettingsView.keyStartMode) ?? 0;
      if (mode == 0) {
        final DateTime now = DateTime.now();
        number = now.day.toString();
        month = now.month.toString();
      }
    }

    await loadFact(number, month, null);
  }

}