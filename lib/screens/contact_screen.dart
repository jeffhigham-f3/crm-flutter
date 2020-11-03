import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/widgets/contact/contact_list_widget.dart';
import 'package:verb_crm_flutter/widgets/search_box_widget.dart';
import 'package:verb_crm_flutter/contact/import.dart';
import 'package:verb_crm_flutter/service/tray_io/tray_io_solution_instance_service.dart';
import 'package:provider/provider.dart';

class PeopleScreen extends StatefulWidget {
  static const String id = 'people_screen';

  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  @override
  // void initState() {
  // loadContacts(context);
  // super.initState();
  // }

  // Future<void> loadContacts(BuildContext context) async {
  // final solutionInstanceService = context.read<TrayIOSolutionInstanceService>();
  // final contactService = context.read<ContactService>();
  // if (contactService.hasContacts) {
  //   contactService.refreshAll();
  //   return;
  // }
  // await contactService.getAll(
  //   triggerUrl: solutionInstanceService.firstWorkflowUrl(),
  // );
  // }

  @override
  Widget build(BuildContext context) {
    final contactService = context.watch<ContactService>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SearchBoxWidget(
          onChanged: (String text) => contactService.searchAll(searchText: text),
        ),
        Expanded(
          child: StreamBuilder(
            stream: contactService.stream,
            builder: (context, snapshot) {
              List<ContactListWidget> widgets = [];
              if (!snapshot.hasData) {
                contactService.refreshAll();
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
              return RefreshIndicator(
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: widgets,
                ),
                onRefresh: (() async {
                  await contactService.refreshAll();
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}
