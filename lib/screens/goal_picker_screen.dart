import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/models/goal_manager.dart';
import 'package:verb_crm_flutter/screens/crm_picker_screen.dart';

class GoalPickerScreen extends StatefulWidget {
  static const String id = 'goal_picker_screen';
  @override
  _GoalPickerScreenState createState() => _GoalPickerScreenState();
}

class _GoalPickerScreenState extends State<GoalPickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "What goals are important to you?",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: Provider.of<GoalManager>(context, listen: true).entities.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (() {
                      final goal = Provider.of<GoalManager>(context, listen: false).entities[index];
                      Provider.of<GoalManager>(context, listen: false).toggle(goal: goal);
                    }),
                    child: Card(
                      child: Container(
                        margin: EdgeInsets.only(top: 2.0),
                        height: 75,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: (Provider.of<GoalManager>(context, listen: false).entities[index].enabled)
                                    ? Icon(
                                        Icons.check_box,
                                        color: Theme.of(context).accentColor,
                                      )
                                    : Icon(
                                        Icons.check_box_outline_blank,
                                      ),
                              ),
                              Container(
//                                padding: const EdgeInsets.all(8.0),
                                margin: const EdgeInsets.all(8.0),
                                child: Text(Provider.of<GoalManager>(context, listen: false).entities[index].name,
                                    style: Theme.of(context).textTheme.headline6),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: OutlineButton(
                  child: Text("Continue"),
                  onPressed: () => {
                    Navigator.pushReplacementNamed(
                      context,
                      CrmPickerScreen.id,
                    ),
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
