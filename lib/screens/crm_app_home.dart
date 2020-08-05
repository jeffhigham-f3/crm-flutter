import 'package:flutter/material.dart';

class CrmAppHome extends StatefulWidget {
  static const String id = 'crm_app_home';
  CrmAppHome({Key key}) : super(key: key);

  @override
  _CrmAppHomeState createState() => _CrmAppHomeState();
}

class _CrmAppHomeState extends State<CrmAppHome> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Goals',
      style: optionStyle,
    ),
    Text(
      'Media',
      style: optionStyle,
    ),
    Text(
      'Contacts',
      style: optionStyle,
    ),
    Text(
      'Activity Feed',
      style: optionStyle,
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_on),
            title: Text('Goals'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            title: Text('Media'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Contacts'),
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
