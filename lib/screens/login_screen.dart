import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/goal_picker_screen.dart';
import 'package:verb_crm_flutter/widgets/import.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login_screen';
  final String logo_url =
      "https://uploads-ssl.webflow.com/5d6eefb700df075bfe44a1b5/5d6ef3922fd62f3a7520970a_verb-logo.png";
  @override
  Widget build(BuildContext context) {
    return LoginWidget(logo_url: logo_url);
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    Key key,
    @required this.logo_url,
  }) : super(key: key);

  final String logo_url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: Form(
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
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Username",
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .65,
                child: TextFormField(
                  obscureText: true,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .65,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    textColor: Colors.white,
                    color: Colors.white.withOpacity(0.2),
                    onPressed: () => {
                      Navigator.pushReplacementNamed(
                        context,
                        GoalPickerScreen.id,
                      ),
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
