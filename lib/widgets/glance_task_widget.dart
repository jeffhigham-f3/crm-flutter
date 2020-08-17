import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/glance_task.dart';
import 'package:verb_crm_flutter/screens/glance_detail_screen.dart';

class GlanceTaskWidget extends StatefulWidget {
  final GlanceTask task;
  const GlanceTaskWidget({Key key, this.task}) : super(key: key);

  @override
  _GlanceTaskWidgetState createState() => _GlanceTaskWidgetState();
}

class _GlanceTaskWidgetState extends State<GlanceTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GlanceDetailScreen(
                task: widget.task,
              ),
              fullscreenDialog: true,
            ),
          )
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    widget.task.description,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
