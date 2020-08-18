import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/widgets/contact_list_widget.dart';
import 'package:verb_crm_flutter/service/contact_service.dart';
import 'package:provider/provider.dart';

class PeopleContactsScreen extends StatefulWidget {
  static const String id = 'glance_later_screen';

  @override
  _PeopleContactsScreenState createState() => _PeopleContactsScreenState();
}

class _PeopleContactsScreenState extends State<PeopleContactsScreen> {
  @override
  Widget build(BuildContext context) {
    final contactManager = context.watch<ContactService>();

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