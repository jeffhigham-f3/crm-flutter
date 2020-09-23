import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:verb_crm_flutter/secure_constants.dart';
import 'package:verb_crm_flutter/models/tray_io/tray_solution_instance.dart';
import 'package:verb_crm_flutter/service/tray_io_solution_instance_service.dart';
import 'package:verb_crm_flutter/service/tray_io_user_service.dart';
import 'package:verb_crm_flutter/service/auth_service.dart';
import 'package:verb_crm_flutter/widgets/solution_instance_widget.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class SolutionInstanceScreen extends StatefulWidget {
  static const String id = 'goal_picker_screen';

  @override
  _SolutionInstanceScreenState createState() => _SolutionInstanceScreenState();
}

class _SolutionInstanceScreenState extends State<SolutionInstanceScreen> {
  @override
  void initState() {
    final solutionInstanceService = context.read<TrayIOSolutionInstanceService>();
    final trayUserService = context.read<TrayIOUserService>();
    trayUserService.createUserToken().then((accessToken) {
      solutionInstanceService
          .getSolutionInstances(
        accessToken: trayUserService.currentUser.accessToken,
        ownerId: trayUserService.currentUser.id,
      )
          .catchError((e) {
        print(e.toString());
      });
    }).catchError((e) {
      print(e.toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final solutionInstanceService = context.watch<TrayIOSolutionInstanceService>();

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "Solution Instances",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: StreamBuilder(
                stream: solutionInstanceService.stream,
                builder: (context, snapshot) {
                  List<SolutionInstanceWidget> widgets = [];
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  for (var instance in snapshot.data) {
                    widgets.add(SolutionInstanceWidget(instance: instance));
                  }
                  return ListView(
                    padding: const EdgeInsets.all(8),
                    children: widgets,
                  );
                },
              ),
            ),
            Expanded(
              child: Center(
                child: OutlineButton(
                  child: Text("Done"),
                  onPressed: (() {
                    Navigator.pop(context);
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
