import 'package:flutter/material.dart';

import '../views/number_fact_view.dart';

import 'about_view.dart';
import 'settings_view.dart';

class NumberFactsScreen extends StatefulWidget {
  const NumberFactsScreen({Key? key}) : super(key: key);

  @override
  _NumberFactsScreenState createState() => _NumberFactsScreenState();
}

class _NumberFactsScreenState extends State<NumberFactsScreen> {
  int _currentPageIndex = 0;

  final List<Widget> _views = <Widget>[
    const NumberFactView(mode: NumberFactViewMode.dates),
    const NumberFactView(mode: NumberFactViewMode.trivia),
    const NumberFactView(mode: NumberFactViewMode.math),
    const SettingsView(),
    const AboutView()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Facts about numbers')),
        body: IndexedStack(
          index: _currentPageIndex,
          children: _views,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentPageIndex,
          onTap: (int index) => setState(() {
            _currentPageIndex = index;
          }),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              label: 'Dates',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.question_answer_outlined),
              label: 'Trivia',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school_outlined),
              label: 'Math',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.copyright),
              label: 'About',
            ),
          ],
        ),
      ),
    );
  }
}
