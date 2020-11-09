import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/service/import.dart';
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
    GlanceHomeScreen(
      key: PageStorageKey('home-screen'),
    ),
    PeopleScreen(
      key: PageStorageKey('people-screen'),
    ),
    CrmScreen(
      key: PageStorageKey('crm-screen'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    final actionService = context.watch<ActionsService>();

    return Scaffold(
      appBar: AppBar(
        title: actionService.title,
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
            child: Center(
              child: Hero(
                tag: 'profile-${authService.currentUser.id}',
                child: ProfileAvatar(
                  imageUrl: authService.currentUser.photoUrl,
                  radius: 16.0,
                  backgroundColor: Theme.of(context).accentColor,
                  borderColor: Colors.white,
                  initials: authService.currentUser.initials,
                  hasBorder: true,
                  isActive: false,
                ),
              ),
            ),
          ),
        ),
        actions: actionService.actions,
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
      // floatingActionButton: FloatingActionButton(
      //   elevation: 0.5,
      //   highlightElevation: 0.4,
      //   mini: true,
      //   child: Icon(
      //     Icons.video_call,
      //   ),
      //   onPressed: (() {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => LiveVideoScreen(),
      //         fullscreenDialog: true,
      //       ),
      //     );
      //   }),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Palette.scaffold,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dynamic_feed),
            label: 'Verb',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'People',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.movie),
          //   label: 'Media',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: 'Apps',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
