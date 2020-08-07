import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/glance/glance_today.dart';
import 'package:verb_crm_flutter/screens/glance/glance_tomorrow.dart';
import 'package:verb_crm_flutter/screens/glance/glance_later.dart';

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
      body: Stack(
        children: [
          new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: new Container(
              color: Colors.deepPurpleAccent[200].withOpacity(0.0),
              padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 5.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Today",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurpleAccent[100],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Divider(
                              thickness: 3.0,
                              color: Colors.deepPurpleAccent[100],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Tomorrow (4)",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Divider(
                              thickness: 3.0,
                              color: Colors.deepPurpleAccent[200].withAlpha(0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Later (9)",
                            style: TextStyle(
//                              fontWeight: FontWeight.bold,
                                ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Divider(
                              thickness: 3.0,
                              color: Colors.deepPurpleAccent[200].withAlpha(0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return _pages[index % _pages.length];
            },
          ),
        ],
      ),
    );
  }
}
