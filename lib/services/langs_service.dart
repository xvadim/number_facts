//https://stackoverflow.com/questions/56999448/display-country-flag-character-in-flutter
//https://stackoverflow.com/questions/42234666/get-emoji-flag-by-country-code

import 'package:shared_preferences/shared_preferences.dart';

class LangInfo {
  const LangInfo(this.code, this.name, this.flag);

  final String? code;
  final String name;
  final String flag;

  static const String defaultLang = 'en';

  @override
  String toString() => '$flag $name (${code ?? defaultLang})';
}

class LangsService {
  static const String defaultFlag = '🇬🇧';
  static const String keySecondLang = 'secondLang';

  static const List<LangInfo> supportedLangs = <LangInfo>[
    LangInfo(null, 'English', defaultFlag),
    LangInfo('de', 'Deutsch', '🇩🇪'),
    LangInfo('es', 'Español', '🇪🇸'),
    LangInfo('ru', 'Русский', '🇷🇺'),
    LangInfo('uk', 'Українська', '🇺🇦'),
    LangInfo('fr', 'Français', '🇫🇷'),
  ];

  String? lang(int index) => index >= 0 && index < _langs.length ? _langs[index] : null;
  String flag(int index) => index >= 0 && index < _langs.length ? _flags[index] : defaultFlag;

  String _langFlag(String? code) =>
      supportedLangs.firstWhere((lang) => lang.code == code).flag;

  Future<void> loadLangSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? secondLang = prefs.getString(keySecondLang);
    setSecondLang(secondLang);
  }

  void setSecondLang(String? lang) {
    _langs[1] = lang == LangInfo.defaultLang ? null : lang;
    _flags[1] = _langFlag(_langs[1]);
  }

  final List<String?> _langs = [null, null];
  final List<String> _flags = [defaultFlag, defaultFlag];

}

