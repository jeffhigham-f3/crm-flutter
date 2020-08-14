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
            floating: true,
            title: Text('${this.contact.firstName} ${this.contact.lastName}'),
          ),
          SliverToBoxAdapter(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
