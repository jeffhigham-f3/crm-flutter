import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/contact.dart';
import 'package:verb_crm_flutter/widgets/profile_avatar.dart';

class ContactDetailScreen extends StatelessWidget {
  final Contact contact;

  const ContactDetailScreen({Key key, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            leading: null,
            floating: true,
            pinned: false,
            snap: true,
            collapsedHeight: 150,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              title: _ContactAvatar(contact: contact),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Status',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    (contact.online) ? 'Online' : 'Offline',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Account ID',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    contact.id,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Email',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    contact.email,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Phone',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    contact.phone,
                    style: Theme.of(context).textTheme.subtitle1,
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

class _ContactAvatar extends StatelessWidget {
  const _ContactAvatar({
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
          child: ProfileAvatar(
            imageUrl: contact.photoUrl,
            radius: 40.0,
            backgroundColor: contact.accentColor,
            borderColor: Colors.white,
            hasBorder: true,
            isActive: contact.online,
            initials: contact.initials,
          ),
        ),
        Text('${this.contact.firstName} ${this.contact.lastName}'),
      ],
    );
  }
}
