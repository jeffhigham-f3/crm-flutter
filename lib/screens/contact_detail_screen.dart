import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/contact/import.dart';
import 'package:verb_crm_flutter/service/import.dart';
import 'package:verb_crm_flutter/widgets/profile_avatar.dart';

class PersonDetailScreen extends StatelessWidget {
  final Contact contact;
  const PersonDetailScreen({Key key, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeService = context.watch<ThemeService>();
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            collapsedHeight: 200,
            expandedHeight: 200,
            flexibleSpace: Container(
              decoration: themeService.appBarGradientDecoration,
              child: _ContactNavAvatar(contact: contact),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 22),
                  ContactActions(),
                  SizedBox(height: 22),
                  ContactTags(tags: contact.tags),
                  SizedBox(height: 20),
                  ContactPropertyWidget(
                    title: 'Account',
                    content: Text(contact.id),
                  ),
                  ContactPropertyWidget(
                    title: 'Email',
                    content: Text(contact.email),
                  ),
                  ContactPropertyWidget(
                    title: 'Phone',
                    content: Text(contact.phone),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactTags extends StatelessWidget {
  final List<String> tags;
  const ContactTags({Key key, this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tagWidgets = tags
        .map((t) => Chip(
            backgroundColor: Theme.of(context).primaryColor,
            label: Text(
              t,
              style: TextStyle(
                color: Colors.grey[200],
              ),
            )))
        .toList();
    return Center(
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        spacing: 4,
        children: tagWidgets,
      ),
    );
  }
}

class ContactActions extends StatelessWidget {
  const ContactActions({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ContactActionWidget(title: 'message', icon: Icons.message),
        ContactActionWidget(title: 'phone', icon: Icons.phone),
        ContactActionWidget(title: 'live', icon: Icons.video_call),
        ContactActionWidget(title: 'mail', icon: Icons.mail),
      ],
    );
  }
}

class _ContactNavAvatar extends StatelessWidget {
  const _ContactNavAvatar({
    Key key,
    @required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 40,
          ),
          child: Hero(
            tag: 'profile-${contact.id}',
            child: ProfileAvatar(
              imageUrl: contact.photoUrl,
              imageAsset: contact.photoAsset,
              radius: 60.0,
              backgroundColor: contact.accentColor,
              borderColor: Colors.white,
              hasBorder: true,
              isActive: contact.online,
              initials: contact.initials,
            ),
          ),
        ),
        Text(
          '${contact.firstName} ${contact.lastName}',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headline6.fontSize,
            fontWeight: Theme.of(context).textTheme.headline6.fontWeight,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class ContactActionWidget extends StatelessWidget {
  final String title;
  final IconData icon;

  const ContactActionWidget({
    Key key,
    this.title,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Theme.of(context).accentColor.withOpacity(0.1),
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
        onTap: () => print('$title action'),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).accentColor,
                ),
                SizedBox(
                  height: 4,
                  width: 50,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

class ContactPropertyWidget extends StatelessWidget {
  final String title;
  final Widget content;

  const ContactPropertyWidget({
    Key key,
    @required this.title,
    @required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => print(title),
        splashColor: Theme.of(context).accentColor.withOpacity(0.1),
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline6,
              ),
              content,
            ],
          ),
        ),
      ),
    );
  }
}
