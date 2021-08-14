
import '../services/numbers_api.dart';
import '../services/service_locator.dart';
import '../services/translator_api.dart';

/// A model for a fact about number
class NumberFactModel {

  Future<void> loadDateFact(String? number, String? lang) async {
    _prepareLoading();
    _setBaseFact(await serviceLocator<NumbersApi>().loadDateFact(number));

    await changeLang(lang);
  }

  Future<void> loadTriviaFact(String? number, String? lang) async {
    _prepareLoading();
    _setBaseFact(await serviceLocator<NumbersApi>().loadTriviaFact(number));

    await changeLang(lang);
  }

  Future<void> loadMathFact(String? number, String? lang) async {
    _prepareLoading();
    _setBaseFact(await serviceLocator<NumbersApi>().loadMathFact(number));

    await changeLang(lang);
  }

  Future<void> changeLang(String? lang) async {
    if (_curLang == lang && _numberFacts[_curLang] != null) {
      return;
    }
    _curLang = lang;

    await _translateFact();
  }

  String get numberFact => _numberFacts[_curLang] ?? '';
  String? get curLang => _curLang;


  String? _curLang;
  final Map<String?, String?> _numberFacts = <String?, String?>{};

  void _prepareLoading() {
    _numberFacts.clear();
  }

  void _setBaseFact(NumberInfo? info) {
    _numberFacts[null] = info?.text ?? 'Not found';
  }

  Future<void> _translateFact() async {
    final TranslatorApi translatorApi = serviceLocator<TranslatorApi>();
    _numberFacts[_curLang] = await translatorApi.translate(_numberFacts[null]!, to: _curLang);
  }

}