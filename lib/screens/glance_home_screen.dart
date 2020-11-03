import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/service/glance/glance_service.dart';
import 'package:verb_crm_flutter/widgets/import.dart';
import 'package:verb_crm_flutter/widgets/contact/contact_followup_widget.dart';

class GlanceHomeScreen extends StatefulWidget {
  static const String id = 'glance_hom_screen';

  @override
  _GlanceHomeScreenState createState() => _GlanceHomeScreenState();
}

class _GlanceHomeScreenState extends State<GlanceHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final glanceService = context.watch<GlanceService>();

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
            child: StreamBuilder(
              stream: glanceService.entityStream(),
              builder: (context, snapshot) {
                List<Widget> widgets = [];
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                widgets.add(
                  ContactFollowUpWidget(
                    task: snapshot.data[0],
                  ),
                );
                for (var task in snapshot.data) {
                  widgets.add(GlanceTaskWidget(task: task));
                }
                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: widgets,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
