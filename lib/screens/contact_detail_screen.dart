import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/contact.dart';

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [],
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
          child: CircleAvatar(
            radius: 45,
            backgroundColor: Theme.of(context).backgroundColor,
            child: CircleAvatar(
                backgroundImage: (this.contact.photoUrl != null) ? NetworkImage(this.contact.photoUrl) : null,
                radius: 40,
                backgroundColor: Theme.of(context).canvasColor,
                child: (this.contact.photoUrl == null)
                    ? Text(
                        this.contact.initials,
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 42.0,
                        ),
                      )
                    : null),
          ),
        ),
        Text('${this.contact.firstName} ${this.contact.lastName}'),
      ],
    );
  }
}
