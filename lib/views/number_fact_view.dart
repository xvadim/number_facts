import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../view_models/fact_view_model.dart';
import '../widgets/number_selector.dart';

enum NumberFactViewMode { dates, trivia, math }

class NumberFactView extends StatefulWidget {
  const NumberFactView({Key? key, required this.mode}) : super(key: key);

  final NumberFactViewMode mode;

  @override
  _NumberFactViewState createState() => _NumberFactViewState();
}

class _NumberFactViewState extends State<NumberFactView> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FactViewModel>(
      create: (_) => FactViewModel(widget.mode),
      child: Column(
        children: <Widget>[
          NumberSelector(
            withMonthPicker: widget.mode == NumberFactViewMode.dates,
            onNumberSelected: (
              BuildContext context, {
              String? number,
              String? month,
              String? lang,
            }) async =>
                context.read<FactViewModel>().loadFact(number, month, lang),
            onLangChanged: (BuildContext context,
                    {String? lang}) async =>
                context.read<FactViewModel>().changeLang(lang),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_modeDescription[widget.mode]!,
                style: Theme.of(context).textTheme.headline5),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Center(child: _FactView()),
            ),
          ),
        ],
      ),
    );
  }

  static final Map<NumberFactViewMode, String> _modeDescription =
  <NumberFactViewMode, String>{
    NumberFactViewMode.dates: 'Facts about dates',
    NumberFactViewMode.trivia: 'Trivia facts about numbers',
    NumberFactViewMode.math: 'Math facts about numbers',
  };
}

class _FactView extends StatelessWidget {
  const _FactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String fact =
        context.select<FactViewModel, String>((model) => model.numberFact);
    final bool isLoading =
        context.select<FactViewModel, bool>((model) => model.isLoading);
    return isLoading
        ? const CircularProgressIndicator()
        : Text(fact, style: Theme.of(context).textTheme.headline6);
  }
}
