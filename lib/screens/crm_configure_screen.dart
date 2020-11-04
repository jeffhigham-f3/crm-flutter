import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/crm/import.dart';

class CrmConfigureScreen extends StatelessWidget {
  final Crm crm;

  const CrmConfigureScreen({Key key, this.crm}) : super(key: key);

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
            flexibleSpace: Hero(
              tag: 'crm-${crm.id}',
              child: Container(
                decoration: Palette.appBarGradientDecoration,
                child: Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(12),
                  width: MediaQuery.of(context).size.width * .25,
                  child: Image.asset('assets/${crm.slug}.png'),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Text('Contacts'),
                  ),
                  Card(
                    child: Text('Media'),
                  ),
                  Card(
                    child: Text('Verb AI'),
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
