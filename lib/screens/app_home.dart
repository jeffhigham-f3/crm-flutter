import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/people_home_screen.dart';
import 'package:verb_crm_flutter/screens/live_video_screen.dart';
import 'package:verb_crm_flutter/screens/crm_picker_screen.dart';
import 'package:verb_crm_flutter/screens/profile_screen.dart';
import 'package:verb_crm_flutter/screens/glance_home_screen.dart';

class AppHome extends StatefulWidget {
  static const String id = 'crm_app_home';
  AppHome({Key key}) : super(key: key);
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    GlanceHomeScreen(),
    PeopleHomeScreen(),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Media',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'All of the digital content you need to share and grow your business!',
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        ),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Activity',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Real-time activity and reporting',
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        ),
      ],
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verb'),
        leading: GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
                fullscreenDialog: true,
              ),
            )
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              child: Center(
                child: Icon(Icons.person),
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            tooltip: "Connectors",
            icon: const Icon(
              Icons.sync,
            ),
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CrmPickerScreen(
                      modal: true,
                    ),
                    fullscreenDialog: true,
                  ))
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.5,
        highlightElevation: 0.4,
        mini: true,
        child: Icon(
          Icons.video_call,
        ),
        onPressed: (() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LiveVideoScreen(),
              fullscreenDialog: true,
            ),
          );
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('Glance'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('People'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            title: Text('Media'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Activity'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
