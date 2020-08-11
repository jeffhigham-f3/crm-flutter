import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/glance_task.dart';

class GlanceDetailScreen extends StatelessWidget {
  final GlanceTask task;

  const GlanceDetailScreen({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            floating: true,
            title: Text(this.task.name),
          ),
          SliverToBoxAdapter(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
