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
            Expanded(
              flex: 11,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Bounce(
                      duration: Duration(milliseconds: 800),
                      child: Container(
                        width: 150.0,
                        constraints: BoxConstraints(
                          maxHeight: 140,
                        ),
                        margin: EdgeInsets.only(bottom: 30.0),
                        child: Image.asset('assets/verb-logo.png'),
                      ),
                    ),
                    AccountFormForm(
                      loginType: LoginType.firebaseLogin,
                    ),
                  ]),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () => print('Sign Up Button Pressed'),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don\'t have an Account? ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
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
