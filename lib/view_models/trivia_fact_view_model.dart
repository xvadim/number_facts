import 'fact_view_model.dart';

class TriviaFactViewModel extends FactViewModel {
  @override
  Future<void> loadNumberFact(String? number, String? lang) async {
    await factModel.loadTriviaFact(number, lang);
  }
}