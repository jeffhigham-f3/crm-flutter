import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/widgets/contact_list_widget.dart';
import 'package:verb_crm_flutter/service/contact_service.dart';
import 'package:verb_crm_flutter/service/tray_io/tray_io_solution_instance_service.dart';
import 'package:provider/provider.dart';

class PeopleScreen extends StatefulWidget {
  static const String id = 'people_screen';

  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  @override
  void initState() {
    final solutionInstanceService = context.read<TrayIOSolutionInstanceService>();
    final contactService = context.read<ContactService>();
    // TODO: - Refactor this logic, also duplicated in refresh.
    if (contactService.contacts.length == 0) {
      if (solutionInstanceService.activeInstances.length != 0 &&
          solutionInstanceService.activeInstances.first.workflows.length != 0) {
        final instance = solutionInstanceService.activeInstances.first;
        if (!instance.enabled) {
          return;
        }
        final workflow = instance.workflows.first;
        if (workflow == null) {
          return;
        }
        contactService.getAll(triggerUrl: workflow.triggerUrl);
      }
    } else {
      contactService.refreshAll();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final contactService = context.watch<ContactService>();
    final solutionInstanceService = context.watch<TrayIOSolutionInstanceService>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SearchBoxWidget(),
        Expanded(
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
              return RefreshIndicator(
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: widgets,
                ),
                onRefresh: (() async {
                  if (solutionInstanceService.activeInstances.length != 0 &&
                      solutionInstanceService.activeInstances.first.workflows.length != 0) {
                    final instance = solutionInstanceService.activeInstances.first;
                    if (!instance.enabled) {
                      return;
                    }
                    final workflow = instance.workflows.first;
                    if (workflow == null) {
                      return;
                    }
                    contactService.getAll(triggerUrl: workflow.triggerUrl);
                  }
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SearchBoxWidget extends StatefulWidget {
  @override
  _SearchBoxWidgetState createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> {
  @override
  Widget build(BuildContext context) {
    final contactService = context.watch<ContactService>();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).cardColor,
      ),
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: TextField(
          onChanged: (String text) => contactService.searchAll(searchText: text),
          autofocus: true,
          keyboardType: TextInputType.text,
          style: const TextStyle(
            fontSize: 18.0,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: '',
            hintStyle: TextStyle(
              fontSize: 18.0,
            ),
            prefixIcon: Icon(
              Icons.search,
            ),
          )),
    );
  }
}
