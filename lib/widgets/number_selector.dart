import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/langs_service.dart';
import '../services/service_locator.dart';

typedef OnNumberSelected = Function(
  BuildContext context, {
  String? number,
  String? lang,
});

typedef OnLangChanged = Function(
  BuildContext context, {
  String? lang,
});

class NumberSelector extends StatefulWidget {
  const NumberSelector({
    Key? key,
    required this.onNumberSelected,
    required this.onLangChanged,
    this.withMonthPicker = false,
  }) : super(key: key);

  final OnNumberSelected onNumberSelected;
  final OnLangChanged onLangChanged;
  final bool withMonthPicker;

  @override
  _NumberSelectorState createState() => _NumberSelectorState();
}

class _NumberSelectorState extends State<NumberSelector> {
  @override
  void initState() {
    super.initState();

    if (widget.withMonthPicker) {
      _month = '1';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          //lang selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: _LangSelector(
              onLangChanged: (String? lang) {
                _lang = lang;
                widget.onLangChanged(context, lang: _lang);
              },
            ),
          ),
          if (widget.withMonthPicker)
            _MonthPicker(onValueChanged: (String? month) => _month = month),
          //number
          Expanded(
            child: TextField(
              controller: _textController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (String number) => widget.onNumberSelected(context,
                  number: _normalizedNumber(number), lang: _lang),
            ),
          ),
          //get a number fact
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: IconButton(
              onPressed: () => widget.onNumberSelected(
                context,
                number: _normalizedNumber(_textController.text.isNotEmpty
                    ? _textController.text
                    : null),
                lang: _lang,
              ),
              icon: const FaIcon(FontAwesomeIcons.fileDownload),
            ),
          ),
          //get a random number fact
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: IconButton(
              onPressed: () => widget.onNumberSelected(context, lang: _lang),
              icon: const FaIcon(FontAwesomeIcons.diceD6),
            ),
          ),
        ],
      ),
    );
  }

  String? _normalizedNumber(String? number) {
    if (number == null) {
      return null;
    }

    return _month == null ? number : '$_month/$number';
  }

  final TextEditingController _textController = TextEditingController();
  String? _month;
  String? _lang;
}

class _LangSelector extends StatefulWidget {
  const _LangSelector({Key? key, required this.onLangChanged})
      : super(key: key);

  final Function(String?) onLangChanged;

  @override
  __LangSelectorState createState() => __LangSelectorState();
}

class __LangSelectorState extends State<_LangSelector> {
  final LangsService langsService = serviceLocator<LangsService>();

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          setState(() {
            _curLangIndex = 1 - _curLangIndex;
            widget.onLangChanged(langsService.lang(_curLangIndex));
          });
        },
        child: Text(langsService.flag(_curLangIndex)));
  }

  int _curLangIndex = 0;
}

class _MonthPicker extends StatefulWidget {
  const _MonthPicker({Key? key, required this.onValueChanged})
      : super(key: key);

  final ValueChanged<String?> onValueChanged;

  @override
  __MonthPickerState createState() => __MonthPickerState();
}

class __MonthPickerState extends State<_MonthPicker> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String?>(
      value: _month,
      elevation: 4,
      onChanged: (String? newValue) {
        setState(() {
          _month = newValue;
          widget.onValueChanged(newValue);
        });
      },
      items: _months
          .asMap()
          .map(
            (key, value) => MapEntry(
              key,
              DropdownMenuItem<String>(
                  value: (key + 1).toString(), child: Text(value)),
            ),
          )
          .values
          .toList(),
    );
  }

  static const List<String> _months = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String? _month = '1';
}
