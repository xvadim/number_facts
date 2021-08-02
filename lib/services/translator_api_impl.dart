import 'package:translator/translator.dart';

import 'translator_api.dart';

class TranslatorApiImpl extends TranslatorApi {
  final _translator = GoogleTranslator();

  @override
  Future<String> translate(String text, {required String? to}) async {
    if (to == null) {
      return text;
    }
    try {
      return (await _translator.translate(text, from: 'en', to: to)).text;
    } on Exception catch(e) {
      print('Translation error: $e');
      return text;
    }
  }
}
