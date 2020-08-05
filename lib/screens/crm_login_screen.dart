import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/crm_picker_screen.dart';

class CrmLoginScreen extends StatefulWidget {
  static const String id = 'crm_login_screen';

  @override
  _CrmLoginScreenState createState() => _CrmLoginScreenState();
}

class _CrmLoginScreenState extends State<CrmLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .65,
                child: TextFormField(
                  decoration: const InputDecoration(hintText: "CRM Username"),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .65,
                child: TextFormField(
                  decoration: const InputDecoration(hintText: "CRM Password"),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: MaterialButton(
                  minWidth: 200.0,
                  height: 40.0,
                  color: Colors.grey[100],
                  elevation: 0,
                  onPressed: () => {
                    Navigator.pop(
                      context,
                    ),
                  },
                  child: Text('Authenticate'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
