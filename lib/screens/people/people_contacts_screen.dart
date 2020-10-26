import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/widgets/contact_list_widget.dart';
import 'package:verb_crm_flutter/service/contact_service.dart';
import 'package:verb_crm_flutter/service/tray_io/tray_io_solution_instance_service.dart';
import 'package:provider/provider.dart';

class PeopleContactsScreen extends StatefulWidget {
  static const String id = 'glance_later_screen';

  @override
  _PeopleContactsScreenState createState() => _PeopleContactsScreenState();
}

class _PeopleContactsScreenState extends State<PeopleContactsScreen> {
  @override
  void initState() {
    final solutionInstanceService = context.read<TrayIOSolutionInstanceService>();
    final contactService = context.read<ContactService>();

    // TODO: Replace the workflow request with
    if (solutionInstanceService.activeInstances.length != 0 &&
        solutionInstanceService.activeInstances.first.workflows.length != 0) {
      final instance = solutionInstanceService.activeInstances.first;
      if (!instance.enabled) {
        print('Solution Instance [${instance.id}] ${instance.name} is disabled');
        return;
      }

      final workflow = instance.workflows.first;
      if (workflow == null) {
        print('${instance.name} does not have an active workflow.');
        return;
      }
      print('Fetching contacts from triggerUrl: ${workflow.triggerUrl}');
      contactService.getContacts(workflowUrl: workflow.triggerUrl);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final contactService = context.watch<ContactService>();

    return Container(
      child: StreamBuilder(
        stream: contactService.stream,
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
