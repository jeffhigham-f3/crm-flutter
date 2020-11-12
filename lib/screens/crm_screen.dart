import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/crm/import.dart';

class CrmScreen extends StatelessWidget {
  static const String id = 'crm_screen';

  CrmScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final crmService = context.watch<CrmService>();
    final appBarService = context.watch<AppBarService>();
    const List<Widget> actions = [];
    appBarService.setTitle(
      title: const Text('Apps', style: const TextStyle(color: Colors.white)),
    );
    appBarService.setActions(actions: actions);
    appBarService.notify();
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: crmService.crms.length,
          itemBuilder: ((context, index) {
            return CrmWidget(crm: crmService.crms[index]);
          }),
        ),
      ),
    );
  }
}
