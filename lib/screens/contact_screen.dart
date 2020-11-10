import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/widgets/search_box_widget.dart';
import 'package:verb_crm_flutter/contact/import.dart';
import 'package:verb_crm_flutter/config/import.dart';
import 'package:provider/provider.dart';

class PeopleScreen extends StatefulWidget {
  static const String id = 'people_screen';

  PeopleScreen({Key key}) : super(key: key);

  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class _PeopleScreenState extends State<PeopleScreen> {
  @override
  void initState() {
    final actionService = context.read<ActionsService>();
    final contactService = context.read<ContactService>();

    final actions = [
      IconButton(
        tooltip: "Filter Contacts",
        icon: const Icon(
          Icons.filter_list,
        ),
        onPressed: () => {contactService.toggleFilterActive()},
      )
    ];

    actionService.setTitle(
        title: Text(
      'People',
      style: TextStyle(color: Colors.white),
    ));
    actionService.setActions(actions: actions);
    actionService.notify();
    super.initState();
  }

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
        FilterOptionsWidget(),
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

class FilterOptionsWidget extends StatefulWidget {
  @override
  _FilterOptionsWidgetState createState() => _FilterOptionsWidgetState();
}

class _FilterOptionsWidgetState extends State<FilterOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    final contactService = context.watch<ContactService>();

    return AnimatedContainer(
      height: contactService.filterActive ? 48 : 0,
      duration: Duration(milliseconds: 500),
      curve: Curves.linearToEaseOut,
      child: AnimatedOpacity(
        opacity: contactService.filterActive ? 1.0 : 0.0,
        duration: Duration(milliseconds: 250),
        curve: Curves.linearToEaseOut,
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 4,
          children: [
            FilterOptionWidget(filter: kSlugLead),
            FilterOptionWidget(filter: kSlugCustomer),
            FilterOptionWidget(filter: kSlugFollowUp),
            FilterOptionWidget(filter: kSlugOnline),
          ],
        ),
      ),
    );
  }
}

class FilterOptionWidget extends StatelessWidget {
  final String filter;

  const FilterOptionWidget({Key key, this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactService = context.watch<ContactService>();

    return FilterChip(
      label: Text(
        filter,
        style: TextStyle(color: Colors.grey[200]),
      ),
      selected: contactService.hasFilter(filter: filter),
      onSelected: (bool selected) {
        contactService.toggleFilter(selected: selected, filter: filter);
      },
      selectedColor: Theme.of(context).primaryColor,
      checkmarkColor: Colors.grey[100],
    );
  }
}
