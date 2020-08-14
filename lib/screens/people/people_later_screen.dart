import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/widgets/contact_list_widget.dart';
import 'package:verb_crm_flutter/models/contact_manager.dart';
import 'package:provider/provider.dart';

class PeopleLaterScreen extends StatefulWidget {
  static const String id = 'glance_later_screen';

  @override
  _PeopleLaterScreenState createState() => _PeopleLaterScreenState();
}

class _PeopleLaterScreenState extends State<PeopleLaterScreen> {
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
