import 'package:flutter/material.dart';

import '../services/numbers_api.dart';
import '../services/service_locator.dart';
import '../services/translator_api.dart';

abstract class FactViewModel extends ChangeNotifier {

  FactViewModel() {
    loadInitFact();
  }

  Future<void> loadFact(String? number, String? lang) async {

    _curLang = lang;
    _numberFacts.clear();
    _isLoading = true;

    notifyListeners();

    await loadNumberFact(number);

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

  String? _curLang;
  final Map<String?, String?> _numberFacts = <String?, String?>{};
  bool _isLoading = false;

  @protected
  Future<void> loadNumberFact(String? number);

  @protected
  void setBaseFact(NumberInfo? info) {
    _numberFacts[null] = info?.text ?? 'Not found';
  }

  Future<void> _translateFact() async {
    if (_curLang != null) {
      final TranslatorApi translatorApi = serviceLocator<TranslatorApi>();
      _numberFacts[_curLang] = await translatorApi.translate(_numberFacts[null]!, to: _curLang);
    }
  }

  @protected
  Future<void> loadInitFact() async {
    await loadFact(null, null);
  }

}