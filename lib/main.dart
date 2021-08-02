import 'package:flutter/material.dart';

import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import 'services/langs_service.dart';
import 'services/service_locator.dart';
import 'views/number_facts_screen.dart';

Future<void> main() async {
  await Settings.init();

  setupLocator();

  await serviceLocator<LangsService>().loadLangSettings();

  runApp(NumberFactsApp());
}

class NumberFactsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Facts about numbers',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NumberFactsScreen(),
    );
  }
}
