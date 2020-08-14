import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/widgets/contact_list_widget.dart';
import 'package:verb_crm_flutter/models/contact_manager.dart';
import 'package:provider/provider.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';

class PeopleTodayScreen extends StatefulWidget {
  static const String id = 'glance_today_screen';

  @override
  _PeopleTodayScreenState createState() => _PeopleTodayScreenState();
}

class _PeopleTodayScreenState extends State<PeopleTodayScreen> {
  @override
  Widget build(BuildContext context) {
    final contactManager = context.watch<ContactManager>();

    return Container(
      child: StreamBuilder(
        stream: contactManager.entityStream(),
        builder: (context, snapshot) {
          List<ContactListWidget> widgets = [];
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          for (var contact in snapshot.data) {
            widgets.add(
              ContactListWidget(contact: contact),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(8),
            children: widgets,
          );
        },
      ),
    );
  }
}
