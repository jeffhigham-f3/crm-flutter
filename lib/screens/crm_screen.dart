import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/crm/import.dart';

class CrmScreen extends StatefulWidget {
  static const String id = 'crm_screen';

  CrmScreen({Key key}) : super(key: key);

  @override
  _CrmScreenState createState() => _CrmScreenState();
}

class _CrmScreenState extends State<CrmScreen> {
  @override
  void initState() {
    final appBarService = context.read<AppBarService>();
    final List<Widget> actions = [];

    appBarService.setTitle(
        title: Text(
      'Apps',
      style: TextStyle(color: Colors.white),
    ));
    appBarService.setActions(actions: actions);
    appBarService.notify();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final crmService = context.watch<CrmService>();
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: crmService.stream,
          builder: (context, snapshot) {
            List<CrmWidget> widgets = [];
            if (!snapshot.hasData) {
              crmService.refreshAll();
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            final List<Crm> crms = snapshot.data;
            for (var crm in crms) {
              widgets.add(
                CrmWidget(crm: crm),
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
