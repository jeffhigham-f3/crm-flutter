import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/widgets/import.dart';
import 'package:animate_do/animate_do.dart';
import 'package:verb_crm_flutter/enums/import.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Bounce(
              delay: Duration(seconds: 0),
              child: Container(
                width: 150.0,
                margin: EdgeInsets.only(bottom: 30.0),
                child: Image.asset('assets/verb-logo.png'),
              ),
            ),
            FirebaseForm(
              loginType: LoginType.firebaseLogin,
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreenArguments {
  final bool logout;

  LoginScreenArguments({@required this.logout});
}
