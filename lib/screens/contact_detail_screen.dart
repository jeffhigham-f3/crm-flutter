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
//            collapsedHeight: 150,
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
              children: [
                Text(contact.toString()),
              ],
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
            imageUrl: this.contact.photoUrl,
            radius: 40.0,
            backgroundColor: Theme.of(context).accentColor,
            borderColor: Colors.white,
            hasBorder: true,
            isActive: this.contact.online,
          ),
        ),
        Text('${this.contact.firstName} ${this.contact.lastName}'),
      ],
    );
  }
}
