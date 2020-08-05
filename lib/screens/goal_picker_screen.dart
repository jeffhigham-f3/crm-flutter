import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/crm_app_home.dart';

class GoalPickerScreen extends StatefulWidget {
  static const String id = 'goal_picker_screen';
  @override
  _GoalPickerScreenState createState() => _GoalPickerScreenState();
}

class _GoalPickerScreenState extends State<GoalPickerScreen> {
  final List<String> entries = <String>['Goal 1', 'Goal 2', 'Goal N'];

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
                  "Which Sales Goals are important to you?",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(top: 8.0),
                    height: 150,
                    color: Colors.deepPurpleAccent[100],
                    child: Center(
                      child: Text(
                        entries[index],
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
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
                  child: Text("Complete Setup!"),
                  onPressed: () => {
                    Navigator.pushReplacementNamed(
                      context,
                      CrmAppHome.id,
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
