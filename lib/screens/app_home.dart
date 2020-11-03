import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/service/authentication/import.dart';
import 'package:verb_crm_flutter/screens/import.dart';
import 'package:verb_crm_flutter/widgets/profile_avatar.dart';
import 'package:verb_crm_flutter/config/palette.dart';

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
    PeopleScreen(),
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
    CrmScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();

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
                child: ProfileAvatar(
                  imageUrl: authService.currentUser.photoUrl,
                  radius: 16.0,
                  backgroundColor: Theme.of(context).accentColor,
                  borderColor: Colors.white,
                  initials: authService.currentUser.initials,
                  hasBorder: false,
                  isActive: false,
                ),
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            tooltip: "Connectors",
            icon: const Icon(
              Icons.add,
            ),
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SolutionsScreen(
                      modal: true,
                    ),
                    fullscreenDialog: true,
                  ))
            },
          )
        ],
        flexibleSpace: Palette.flexSpaceNavGradient,
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
            label: 'Glance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'People',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Media',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'CRM',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
