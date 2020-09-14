import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/service/tray_io_solution_service.dart';
import 'package:verb_crm_flutter/screens/solution_auth_screen.dart';
import 'package:verb_crm_flutter/screens/app_home.dart';
import 'package:verb_crm_flutter/models/tray_io/tray_solution.dart';
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
  Widget build(BuildContext context) {
    final trayIOSolutionService = context.watch<TrayIOSolutionService>();
    trayIOSolutionService.readIndex();
    return Scaffold(
      body: Container(
        child: StreamBuilder(
          stream: trayIOSolutionService.stream,
          builder: (context, snapshot) {
            List<SolutionCard> widgets = [];
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            for (var solution in snapshot.data) {
              widgets.add(
                SolutionCard(solution: solution),
              );
            }
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      "Which CRM should we connect to?",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 1,
                    ),
                    padding: const EdgeInsets.all(20),
                    children: widgets,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: OutlineButton(
                      child: Text("Continue"),
                      onPressed: (() {
                        (widget.modal != null && widget.modal)
                            ? Navigator.pop(context)
                            : Navigator.pushReplacementNamed(
                                context,
                                AppHome.id,
                              );
                      }),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SolutionCardGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SolutionCard extends StatefulWidget {
  final TraySolution solution;
  const SolutionCard({Key key, this.solution}) : super(key: key);
  @override
  _SolutionCardState createState() => _SolutionCardState();
}

class _SolutionCardState extends State<SolutionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              child: Image.asset('assets/${widget.solution.title}.png'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              widget.solution.title,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: 10.0,
            ),
            (widget.solution.enabled)
                ? Icon(
                    Icons.done,
                  )
                : OutlineButton(
                    child: Text("Configure"),
                    onPressed: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SolutionAuthScreen(
                              solution: widget.solution,
                            ),
                            fullscreenDialog: true,
                          )).then(
                        (value) => {
                          setState(() {}),
                          Scaffold.of(context).showSnackBar(
                            new SnackBar(
                              content: Text(
                                '${widget.solution.title} Connected!',
                                style: Theme.of(context).textTheme.subtitle2,
                                textAlign: TextAlign.center,
                              ),
                              duration: Duration(seconds: 1),
                              backgroundColor: Theme.of(context).accentColor,
                            ),
                          )
                        },
                      );
                    }),
                  ),
          ],
        ),
      ),
    );
  }
}
