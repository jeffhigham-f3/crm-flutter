import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/app/import.dart';

class AppScreen extends StatelessWidget {
  static const String id = 'app_screen';

  AppScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appService = context.watch<AppService>();
    final appBarService = context.watch<AppBarService>();
    const List<Widget> actions = [];
    appBarService.setTitle(
      title: const Text('Apps',
          style: const TextStyle(
            color: Colors.white,
          )),
    );
    appBarService.setActions(actions: actions);
    appBarService.notify();
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: appService.apps.length,
          itemBuilder: ((context, index) {
            return AppWidget(app: appService.apps[index]);
          }),
        ),
      ),
    );
  }
}
