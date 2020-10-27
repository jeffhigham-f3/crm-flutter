import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/service/tray_io/import.dart';
import 'package:provider/provider.dart';

class WorkflowScreen extends StatefulWidget {
  static const String id = 'workflow_screen';

  @override
  _WorkflowScreenState createState() => _WorkflowScreenState();
}

class _WorkflowScreenState extends State<WorkflowScreen> {
  @override
  Widget build(BuildContext context) {
    final workflowService = context.watch<TrayIOWorkflowService>();
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: workflowService.stream,
          builder: (context, snapshot) {
            List<Text> widgets = [];
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            for (var workflow in snapshot.data) {
              widgets.add(
                Text("${workflow.title}"),
              );
            }
            return ListView(
              padding: const EdgeInsets.all(8),
              children: widgets,
            );
          },
        ),
      ),
    );
  }
}
