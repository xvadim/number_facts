import 'fact_view_model.dart';

class MathFactViewModel extends FactViewModel {
  @override
  Future<void> loadNumberFact(String? number, String? lang) async {
    await factModel.loadMathFact(number, lang);
  }
}