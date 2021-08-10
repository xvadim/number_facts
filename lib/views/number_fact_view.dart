import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../view_models/date_fact_view_model.dart';
import '../view_models/fact_view_model.dart';
import '../view_models/math_fact_view_model.dart';
import '../view_models/trivia_fact_view_model.dart';
import '../widgets/number_selector.dart';

enum NumberFactViewMode { dates, trivia, math }

abstract class NumberFactView extends StatelessWidget {
  NumberFactView({Key? key}): super(key: key);

  factory NumberFactView.withMode({Key? key, required NumberFactViewMode mode}) {
    switch(mode) {
      case NumberFactViewMode.dates:
        return _DateFactView(key: key);
      case NumberFactViewMode.trivia:
        return _TriviaFactView(key: key);
      default:
        return _MathFactView(key: key);
    }
  }
}

class _DateFactView extends NumberFactView {
  _DateFactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DateFactViewModel>(
      create: (_) => DateFactViewModel(),
      child: const _NumberViewConsumer<DateFactViewModel>(
        description: 'Facts about dates',
        withMonthPicker: true,
      ),
    );
  }
}

class _TriviaFactView extends NumberFactView {
  _TriviaFactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TriviaFactViewModel>(
      create: (_) => TriviaFactViewModel(),
      child: const _NumberViewConsumer<TriviaFactViewModel>(
        description: 'Trivia facts about numbers',
      ),
    );
  }
}

class _MathFactView extends NumberFactView {
  _MathFactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MathFactViewModel>(
      create: (_) => MathFactViewModel(),
      child: const _NumberViewConsumer<MathFactViewModel>(
        description: 'Math facts about numbers',
      ),
    );
  }
}

class _NumberViewConsumer<T extends FactViewModel> extends StatelessWidget {
  const _NumberViewConsumer({
    Key? key,
    required this.description,
    this.withMonthPicker = false,
  }) : super(key: key);

  final String description;
  final bool withMonthPicker;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NumberSelector(
          withMonthPicker: withMonthPicker,
          onNumberSelected: (
            BuildContext context, {
            String? number,
            String? lang,
          }) async =>
              context.read<T>().loadFact(number, lang),
          onLangChanged: (BuildContext context, {String? lang}) async =>
              context.read<T>().changeLang(lang),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Text(description, style: Theme.of(context).textTheme.headline5),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(child: _FactView<T>()),
          ),
        ),
      ],
    );
  }
}

class _FactView<T extends FactViewModel> extends StatelessWidget {
  const _FactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String fact = context.select<T, String>((model) => model.numberFact);
    final bool isLoading = context.select<T, bool>((model) => model.isLoading);
    return isLoading
        ? const CircularProgressIndicator()
        : Text(fact, style: Theme.of(context).textTheme.headline6);
  }
}
