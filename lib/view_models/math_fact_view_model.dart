import '../services/numbers_api.dart';
import '../services/service_locator.dart';

import 'fact_view_model.dart';

class MathFactViewModel extends FactViewModel {
  @override
  Future<void> loadNumberFact(String? number) async {
    setBaseFact(await serviceLocator<NumbersApi>().loadMathFact(number));
  }
}