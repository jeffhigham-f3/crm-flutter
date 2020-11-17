import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/service/import.dart';
import 'package:verb_crm_flutter/screens/import.dart';
import 'package:verb_crm_flutter/widgets/profile_avatar.dart';
import 'package:verb_crm_flutter/config/palette.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppHome extends StatefulWidget {
  static const String id = 'crm_app_home';
  AppHome({Key key}) : super(key: key);
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(
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
    final appBarService = context.watch<AppBarService>();
    final themeService = context.watch<ThemeService>();
    return Scaffold(
      appBar: AppBar(
        title: appBarService.title,
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
        actions: appBarService.actions,
        flexibleSpace: themeService.flexSpaceNavGradient,
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Palette.scaffold,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.stream),
            label: 'Verb',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.addressBook),
            label: 'People',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.th),
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
