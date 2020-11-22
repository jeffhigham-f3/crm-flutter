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

class _PeopleScreenState extends State<PeopleScreen> {
  @override
  void initState() {
    final appBarService = context.read<AppBarService>();
    final contactService = context.read<ContactService>();

    final actions = [
      IconButton(
        tooltip: "Filter Contacts",
        icon: const Icon(
          Icons.filter_list,
        ),
        onPressed: () => contactService.toggleTagActive(),
      )
    ];

    appBarService.setTitle(
        title: Text(
      'People',
      style: TextStyle(color: Colors.white),
    ));
    appBarService.setActions(actions: actions);
    appBarService.notify();
    // contactService.refreshAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final contactService = context.watch<ContactService>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('Add contact'),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SearchBoxWidget(
            onChanged: (String text) => contactService.searchAll(
              searchText: text,
            ),
          ),
          TagsWidget(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: (() async {
                await contactService.refreshAll();
              }),
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: contactService.visibleContacts.length,
                  itemBuilder: (context, index) {
                    return ContactListWidget(contact: contactService.visibleContacts[index]);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class TagsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contactService = context.watch<ContactService>();

    return AnimatedContainer(
      height: contactService.tagActive ? 48 : 0,
      duration: Duration(milliseconds: 500),
      curve: Curves.linearToEaseOut,
      child: AnimatedOpacity(
        opacity: contactService.tagActive ? 1.0 : 0.0,
        duration: Duration(milliseconds: 250),
        curve: Curves.linearToEaseOut,
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 4,
          children: [
            TagWidget(tag: kSlugLead),
            TagWidget(tag: kSlugCustomer),
            TagWidget(tag: kSlugFollowUp),
            TagWidget(tag: kSlugOnline),
          ],
        ),
      ),
    );
  }
}

class TagWidget extends StatelessWidget {
  final String tag;

  const TagWidget({Key key, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactService = context.watch<ContactService>();

    return FilterChip(
      label: Text(
        tag,
        style: TextStyle(color: Colors.grey[200]),
      ),
      selected: contactService.hasTag(tag: tag),
      onSelected: (bool selected) {
        contactService.toggleTag(tag: tag);
      },
      selectedColor: Theme.of(context).primaryColor,
      checkmarkColor: Colors.grey[100],
    );
  }
}
