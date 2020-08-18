import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/widgets/contact_list_widget.dart';
import 'package:verb_crm_flutter/service/contact_service.dart';
import 'package:provider/provider.dart';

class PeopleCustomersScreen extends StatefulWidget {
  static const String id = 'glance_tomorrow_screen';

  @override
  _PeopleCustomersScreenState createState() => _PeopleCustomersScreenState();
}

class _PeopleCustomersScreenState extends State<PeopleCustomersScreen> {
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
            if (contact.customer == true) {
              widgets.add(
                ContactListWidget(contact: contact),
              );
            }
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
