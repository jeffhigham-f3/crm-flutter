import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/service/tray_io_solution_service.dart';
import 'package:verb_crm_flutter/service/tray_io_solution_instance_service.dart';
import 'package:verb_crm_flutter/service/tray_io_user_service.dart';
import 'package:verb_crm_flutter/widgets/solution_instance_widget.dart';
import 'package:verb_crm_flutter/widgets/solution_widget.dart';
import 'package:provider/provider.dart';

class SolutionsScreen extends StatefulWidget {
  static const String id = 'solution_screen';

  final bool modal;
  const SolutionsScreen({Key key, this.modal}) : super(key: key);

  @override
  _SolutionsScreenState createState() => _SolutionsScreenState();
}

class _SolutionsScreenState extends State<SolutionsScreen> {
  @override
  void initState() {
    final solutionService = context.read<TrayIOSolutionService>();
    final solutionInstanceService = context.read<TrayIOSolutionInstanceService>();
    final trayUserService = context.read<TrayIOUserService>();

    trayUserService.createUserToken().then((accessToken) {
      solutionService
          .getSolutionInstances(
        accessToken: trayUserService.currentUser.accessToken,
      )
          .catchError((e) {
        print(e.toString());
      });

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
    final solutionService = context.watch<TrayIOSolutionService>();
    final solutionInstanceService = context.watch<TrayIOSolutionInstanceService>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Integrations'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          Text(
            'Solutions',
            style: Theme.of(context).textTheme.headline6,
          ),
          Container(
            height: 250,
            child: StreamBuilder(
              stream: solutionService.stream,
              builder: (context, snapshot) {
                List<SolutionWidget> widgets = [];
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                for (var solution in snapshot.data) {
                  widgets.add(
                    SolutionWidget(solution: solution),
                  );
                }
                return ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  children: widgets,
                );
              },
            ),
          ),
          Text(
            'My Instances',
            style: Theme.of(context).textTheme.headline6,
          ),
          Container(
            height: 250,
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
                  physics: const NeverScrollableScrollPhysics(),
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
