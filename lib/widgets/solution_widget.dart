import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/tray_io/tray_solution.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:verb_crm_flutter/service/tray_io_solution_instance_service.dart';
import 'package:verb_crm_flutter/service/tray_io_user_service.dart';
import 'package:provider/provider.dart';

class SolutionWidget extends StatelessWidget {
  final TraySolution solution;
  const SolutionWidget({Key key, this.solution}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final solutionInstanceService = context.watch<TrayIOSolutionInstanceService>();
    final trayUserService = context.watch<TrayIOUserService>();

    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              solution.title,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            SizedBox(height: 8.0),
            Text(
              solution.description,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OutlineButton(
                  child: const Text('Configure Instances'),
                  onPressed: (() async {
                    const url = 'https://tray-embeded.f3code.io';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
