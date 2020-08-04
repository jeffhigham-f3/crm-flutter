import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/crm_picker_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login_screen';
  final String logo_url =
      "https://uploads-ssl.webflow.com/5d6eefb700df075bfe44a1b5/5d6ef3922fd62f3a7520970a_verb-logo.png";
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
                child: Container(
                  width: 150.0,
                  margin: EdgeInsets.only(bottom: 30.0),
                  child: Image.network(
                    this.logo_url,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .65,
                child: TextFormField(
                  decoration: const InputDecoration(hintText: "Username"),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .65,
                child: TextFormField(
                  decoration: const InputDecoration(hintText: "Password"),
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
                    Navigator.pushReplacementNamed(
                      context,
                      CrmPickerScreen.id,
                    ),
                  },
                  child: Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
