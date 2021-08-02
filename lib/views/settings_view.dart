import 'package:flutter/material.dart';

import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import '../services/langs_service.dart';
import '../services/service_locator.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  static const String keyStartMode = 'startMode';

  @override
  Widget build(BuildContext context) {
    return SettingsContainer(
      children: <Widget>[
        DropDownSettingsTile<String>(
          title: 'Second lang:',
          settingKey: LangsService.keySecondLang,
          selected: LangInfo.defaultLang,
          values: LangsService.supportedLangs.asMap().map(
                (_, value) => MapEntry(
                  value.code ?? LangInfo.defaultLang,
                  value.toString(),
                ),
              ),
          onChange: (String lang) =>
              serviceLocator<LangsService>().setSecondLang(lang),
        ),
        DropDownSettingsTile<int>(
          title: 'Show on start:',
          settingKey: keyStartMode,
          selected: 0,
          values: const <int, String>{
            0: 'Current date',
            1: 'Random date',
          },
        ),
      ],
    );
  }
}
