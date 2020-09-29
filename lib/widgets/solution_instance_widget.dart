import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/tray_io/tray_solution_instance.dart';
import 'package:verb_crm_flutter/service/tray_io_solution_instance_service.dart';
import 'package:verb_crm_flutter/service/tray_io_user_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SolutionInstanceWidget extends StatefulWidget {
  final TraySolutionInstance instance;

  const SolutionInstanceWidget({Key key, this.instance}) : super(key: key);

  @override
  _SolutionInstanceWidgetState createState() => _SolutionInstanceWidgetState();
}

class _SolutionInstanceWidgetState extends State<SolutionInstanceWidget> {
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
              widget.instance.name,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 8.0),
            Container(
              height: widget.instance.enabled ? (widget.instance.workflows.length * 50) * 1.0 : 0,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.instance.enabled ? widget.instance.workflows.length : 0,
                  itemBuilder: (BuildContext context, int index) {
                    return OutlineButton(
                      child: Text('Workflow[${index}] - Preview'),
                      onPressed: (() {
                        launch(widget.instance.workflows.elementAt(index).triggerUrl);
                      }),
                    );
                  }),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OutlineButton(
                    child: widget.instance.enabled ? Text("Disable Instance") : Text("Enable Instance"),
                    onPressed: (() {
                      if (widget.instance.enabled) {
                        solutionInstanceService
                            .disableSolutionInstance(
                                accessToken: trayUserService.currentUser.accessToken, instance: widget.instance)
                            .then((value) {
                          solutionInstanceService
                              .getSolutionInstances(
                                  accessToken: trayUserService.currentUser.accessToken,
                                  ownerId: trayUserService.currentUser.id)
                              .catchError((e) {
                            print(e.toString());
                          });
                        }).catchError((e) {
                          print(e.toString());
                        });
                      } else {
                        solutionInstanceService
                            .enableSolutionInstance(
                                accessToken: trayUserService.currentUser.accessToken, instance: widget.instance)
                            .then((value) {
                          solutionInstanceService
                              .getSolutionInstances(
                                  accessToken: trayUserService.currentUser.accessToken,
                                  ownerId: trayUserService.currentUser.id)
                              .catchError((e) {
                            print(e.toString());
                          });
                        }).catchError((e) {
                          print(e.toString());
                        });
                      }
                    })),
                OutlineButton(
                  child: Text("Delete"),
                  onPressed: (() {
                    solutionInstanceService
                        .deleteSolutionInstance(
                            accessToken: trayUserService.currentUser.accessToken, instance: widget.instance)
                        .then((value) {
                      solutionInstanceService
                          .getSolutionInstances(
                              accessToken: trayUserService.currentUser.accessToken,
                              ownerId: trayUserService.currentUser.id)
                          .catchError((e) {
                        print(e.toString());
                      });
                    }).catchError((e) {
                      print(e.toString());
                    });
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
