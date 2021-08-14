import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'fact_view_model.dart';

class DateFactViewModel extends FactViewModel {

  @override
  Future<void> loadNumberFact(String? number, String? lang) async {
    await factModel.loadDateFact(number, lang);
  }

  @override
  Future<void> loadInitFact() async {
    String? number;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int mode = prefs.getInt(keyStartMode) ?? 0;
    if (mode == 0) {
      final DateTime now = DateTime.now();
      number = '${now.month}/${now.day}';
    }

    await loadFact(number, null);
  }

}