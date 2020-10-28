import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/people/people_leads_screen.dart';
import 'package:verb_crm_flutter/screens/people/people_customers_screen.dart';
import 'package:verb_crm_flutter/screens/people_contacts_screen.dart';
import 'package:verb_crm_flutter/widgets/import.dart';

class PeopleHomeScreen extends StatefulWidget {
  static const String id = 'glance_home_screen';
  @override
  _PeopleHomeScreenState createState() => _PeopleHomeScreenState();
}

class _PeopleHomeScreenState extends State<PeopleHomeScreen> {
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
//    PeopleLeadsScreen(),
//    PeopleCustomersScreen(),
    PeopleContactsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          PageviewNavigator(
            children: <Widget>[
//              PageviewNavigationButton(
//                text: "Leads",
//                onPressed: () {
//                  if (_pageController.hasClients) {
//                    _pageController.animateToPage(
//                      0,
//                      duration: const Duration(milliseconds: 400),
//                      curve: Curves.easeInOut,
//                    );
//                  }
//                },
//              ),
//              PageviewNavigationButton(
//                text: "Customers",
//                onPressed: () {
//                  if (_pageController.hasClients) {
//                    _pageController.animateToPage(
//                      1,
//                      duration: const Duration(milliseconds: 400),
//                      curve: Curves.easeInOut,
//                    );
//                  }
//                },
//              ),
//              PageviewNavigationButton(
//                text: "Contacts",
//                onPressed: () {
//                  if (_pageController.hasClients) {
//                    _pageController.animateToPage(
//                      2,
//                      duration: const Duration(milliseconds: 400),
//                      curve: Curves.easeInOut,
//                    );
//                  }
//                },
//              ),
            ],
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
