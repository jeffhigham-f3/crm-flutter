import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/glance/glance_today.dart';
import 'package:verb_crm_flutter/screens/glance/glance_tomorrow.dart';
import 'package:verb_crm_flutter/screens/glance/glance_later.dart';
import 'package:verb_crm_flutter/widgets/import.dart';

class GlanceHomeScreen extends StatefulWidget {
  static const String id = 'glance_home_screen';
  @override
  _GlanceHomeScreenState createState() => _GlanceHomeScreenState();
}

class _GlanceHomeScreenState extends State<GlanceHomeScreen> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = <Widget>[
    GlanceToday(),
    GlanceTomorrow(),
    GlanceLater(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GlanceScreenButton(
                  text: "Today",
                  onPressed: () {
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
                GlanceScreenButton(
                  text: "Tomorro (3)",
                  onPressed: () {
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
                GlanceScreenButton(
                  text: "Later (20)",
                  onPressed: () {
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
            ),
          ),
        ],
      ),
    );
  }
}
