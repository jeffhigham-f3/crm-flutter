import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/widgets/contact_list_widget.dart';
import 'package:verb_crm_flutter/service/contact_service.dart';
import 'package:provider/provider.dart';

class PeopleLeadsScreen extends StatefulWidget {
  static const String id = 'glance_today_screen';

  @override
  _PeopleLeadsScreenState createState() => _PeopleLeadsScreenState();
}

class _PeopleLeadsScreenState extends State<PeopleLeadsScreen> {
  @override
  Widget build(BuildContext context) {
    final contactService = context.watch<ContactService>();

    return Container(
      child: StreamBuilder(
        stream: contactService.entityStream(),
        builder: (context, snapshot) {
          List<ContactListWidget> widgets = [];
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          for (var contact in snapshot.data) {
            if (contact.lead == true) {
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
