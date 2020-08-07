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
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "Which Goals are important to you?",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: Provider.of<GoalManager>(context, listen: true).entities.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (() {
                      final goal = Provider.of<GoalManager>(context, listen: false).entities[index];
                      Provider.of<GoalManager>(context, listen: false).toggle(goal: goal);
                    }),
                    child: Container(
                      margin: EdgeInsets.only(top: 8.0),
                      height: 150,
                      color: (Provider.of<GoalManager>(context, listen: false).entities[index].enabled)
                          ? Colors.deepPurpleAccent[100]
                          : Colors.grey[200],
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (Provider.of<GoalManager>(context, listen: false).entities[index].enabled)
                                  ? Icon(Icons.done)
                                  : null,
                            ),
                            Text(
                              Provider.of<GoalManager>(context, listen: false).entities[index].name,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Center(
                child: RaisedButton(
                  child: Text("Next Step >"),
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
