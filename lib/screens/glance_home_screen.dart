import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/models/glance_task_manager.dart';
import 'package:verb_crm_flutter/widgets/import.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class GlanceHomeScreen extends StatefulWidget {
  static const String id = 'goal_picker_screen';

  @override
  _GlanceHomeScreenState createState() => _GlanceHomeScreenState();
}

class _GlanceHomeScreenState extends State<GlanceHomeScreen> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "Here are your Glance ™ tasks.",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: Provider.of<GlanceTaskManager>(context, listen: true).entities.length,
              itemBuilder: (BuildContext context, int index) {
                return GlanceTaskWidget(
                  task: Provider.of<GlanceTaskManager>(context, listen: true).entities[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
