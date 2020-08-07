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
  static List<Widget> _widgetOptions = <Widget>[
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Glance AI ™️',
          style: optionStyle,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'A customized list of everything you need to do to meet your goals! Let our Glance AI ™️ help you build your business!',
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