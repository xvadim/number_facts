import 'package:get_it/get_it.dart';

import 'langs_service.dart';
import 'numbers_api.dart';
import 'numbers_api_impl.dart';
import 'translator_api.dart';
import 'translator_api_impl.dart';

GetIt serviceLocator = GetIt.instance;

void setupLocator() {
  serviceLocator
    ..registerLazySingleton<NumbersApi>(() => NumbersApiImpl(),
        dispose: (NumbersApi api) => api.dispose())
    ..registerLazySingleton<TranslatorApi>(() => TranslatorApiImpl())
    ..registerSingleton(LangsService());
}
