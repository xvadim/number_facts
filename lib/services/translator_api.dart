abstract class TranslatorApi {
  Future<String> translate(String text, {required String? to});
}