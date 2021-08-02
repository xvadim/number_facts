import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          _UrlText(text: 'A client for http://numbersapi.com'),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Copyright(c) 2021 Vadym A. Khokhlov'),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40.0),
            child: _UrlText(text: 'More apps: https://xvadim.github.io/xbasoft'),
          ),
          Text('Hints:'),
          _Hint(text: 'Change language', leadingWidget: Text('🇬🇧')),
          _Hint(
            text: 'Get a fact about a given number',
            leadingWidget: FaIcon(FontAwesomeIcons.fileDownload),
          ),
          _Hint(
            text: 'Get a random fact',
            leadingWidget: FaIcon(FontAwesomeIcons.diceD6),
          ),
        ],
      ),
    );
  }
}

class _UrlText extends StatelessWidget {
  const _UrlText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SelectableLinkify(
      onOpen: (link) async {
        if (await canLaunch(link.url)) {
          try {
            await launch(link.url);
          } on Exception catch (_) {}
        }
      },
      text: text,
    );
  }
}

class _Hint extends StatelessWidget {
  const _Hint({
    Key? key,
    required this.text,
    required this.leadingWidget,
  }) : super(key: key);

  final String text;
  final Widget leadingWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(8.0), child: leadingWidget),
        Text(text)
      ],
    );
  }
}
