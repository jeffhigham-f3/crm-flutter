import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/widgets/contact/contact_followup_widget.dart';
import 'package:verb_crm_flutter/service/app_bar/app_bar_service.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'hom_screen';

  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final appBarService = context.read<AppBarService>();
    final List<Widget> actions = [];
    appBarService.setTitle(
        title: Text(
      'Verb',
      style: TextStyle(color: Colors.white),
    ));
    appBarService.setActions(actions: actions);
    appBarService.notify();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 1),
          Expanded(
            child: RefreshIndicator(
              onRefresh: (() async {
                print('Refreshing');
              }),
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return ContactFollowUpWidget();
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
