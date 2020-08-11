import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/goal_picker_screen.dart';
import 'package:verb_crm_flutter/widgets/import.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animate_do/animate_do.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signInWithEmailAndPassword() async {
    FirebaseUser user;
    try {
      user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
    } on Exception catch (e) {
      print(e);
    }

    if (user != null) {
      Navigator.pushReplacementNamed(
        context,
        GoalPickerScreen.id,
      );
    } else {
      Scaffold.of(context).showSnackBar(
        new SnackBar(
          content: Text(
            'Login Failed',
            style: Theme.of(context).textTheme.subtitle2,
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 1),
          backgroundColor: Theme.of(context).accentColor,
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Bounce(
            delay: Duration(seconds: 1),
            child: Container(
              width: 150.0,
              margin: EdgeInsets.only(bottom: 30.0),
              child: Image.asset('assets/verb-logo.png'),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .65,
            child: TextFormField(
              controller: _emailController,
              cursorColor: Colors.white,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                hintText: "Email address",
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter an email address';
                }
                return null;
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .65,
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              cursorColor: Colors.white,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                hintText: "Password",
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
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
                textColor: Colors.white,
                color: Colors.white.withOpacity(0.2),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _signInWithEmailAndPassword();
                  }
                },
                child: const Text(
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
    );
  }
}
