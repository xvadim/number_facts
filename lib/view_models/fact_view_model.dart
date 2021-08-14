import 'package:flutter/material.dart';

import '../models/number_fact_model.dart';

/// Base class for view models
/// Derived classes must to override the [loadNumberFact] method
abstract class FactViewModel extends ChangeNotifier {

  FactViewModel() {
    loadInitFact();
  }

  /// Loads a fact for a given [number] and translate it to language [lang]
  Future<void> loadFact(String? number, String? lang) async {

    _isLoading = true;
    notifyListeners();

    await loadNumberFact(number, lang);

    _isLoading = false;
    notifyListeners();
  }

  /// Sets the second language to [lang] and translate the current fact to it.
  Future<void> changeLang(String? lang) async {
    _isLoading = true;
    notifyListeners();

    await factModel.changeLang(lang);

    _isLoading = false;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  String get numberFact => factModel.numberFact;

  bool _isLoading = false;

  @protected
  final NumberFactModel factModel = NumberFactModel();

  @protected
  Future<void> loadNumberFact(String? number, String? lang);

  @protected
  Future<void> loadInitFact() async {
    await loadFact(null, null);
  }

}