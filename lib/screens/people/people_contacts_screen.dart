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
  void initState() {
    // TODO: Dynamically request workflowUrl from solution instance service.
    final workflow = 'https://729cc208-74b4-437d-9370-0974b4ef4b69.trayapp.io';
    final contactService = context.read<ContactService>();
    contactService.getContacts(workflowUrl: workflow);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final conatactService = context.watch<ContactService>();

    return Container(
      child: StreamBuilder(
        stream: conatactService.stream,
        builder: (context, snapshot) {
          List<ContactListWidget> widgets = [];
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            print(snapshot.error);
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
