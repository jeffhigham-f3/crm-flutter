import 'package:flutter/material.dart';

class ContactDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            floating: true,
            title: Text('Contact'),
          ),
          SliverToBoxAdapter(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
