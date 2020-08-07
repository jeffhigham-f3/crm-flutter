import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/glance_home_screen.dart';
import 'package:verb_crm_flutter/screens/live_video_screen.dart';

class CrmAppHome extends StatefulWidget {
  static const String id = 'crm_app_home';
  CrmAppHome({Key key}) : super(key: key);

  @override
  _CrmAppHomeState createState() => _CrmAppHomeState();
}

class _CrmAppHomeState extends State<CrmAppHome> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    GlanceHomeScreen(),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'People',
          style: optionStyle,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Contacts, Prospects, Leads. Everything you need to build relationships!',
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
          'Media',
          style: optionStyle,
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
          style: optionStyle,
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
        leading: IconButton(
          tooltip: "Profile",
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () => {},
        ),
        actions: [
          IconButton(
            tooltip: "Settings",
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () => {},
          )
        ],
        backgroundColor: Colors.deepPurpleAccent[100],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[100],
        foregroundColor: Colors.deepPurpleAccent[100],
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
        selectedItemColor: Colors.deepPurpleAccent[100],
        onTap: _onItemTapped,
      ),
    );
  }
}
