import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/goal_picker_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:verb_crm_flutter/enums/import.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/service/auth_service.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class FirebaseForm extends StatefulWidget {
  LoginType loginType;

  FirebaseForm({Key key, @required this.loginType}) : super(key: key);

  @override
  _FirebaseFormState createState() => _FirebaseFormState();
}

class _FirebaseFormState extends State<FirebaseForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordVerifyController = TextEditingController();

  void _onError(dynamic error) {
    final errorText = Provider.of<AuthService>(context, listen: false).decodeError(exception: error);
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        content: Text(
          errorText,
          style: Theme.of(context).textTheme.subtitle2,
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 1),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }

  void _onSuccess(AuthResult result) {
    Navigator.pushReplacementNamed(
      context,
      GoalPickerScreen.id,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordVerifyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();

    return Form(
      key: _formKey,
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _FormInput(
              hintText: "Email address",
              controller: _emailController,
            ),
            _FormInput(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,
            ),
            _FormButton(
              text: (widget.loginType == LoginType.firebaseLogin) ? "Login" : "Signup",
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  if (widget.loginType == LoginType.firebaseLogin) {
                    authService
                        .firebaseLogin(
                          email: _emailController.text,
                          password: _passwordController.text,
                        )
                        .then((result) => _onSuccess(result))
                        .catchError(
                          (e) => _onError(e),
                        );
                  } else {
                    authService
                        .firebaseSignUp(
                          email: _emailController.text,
                          password: _passwordController.text,
                        )
                        .then((result) => _onSuccess(result))
                        .catchError(
                          (e) => _onError(e),
                        );
                  }
                  _formKey.currentState.reset();
                }
              },
            ),
            Container(
              child: FlatButton(
                onPressed: () => setState(() {
                  if (widget.loginType == LoginType.firebaseLogin) {
                    widget.loginType = LoginType.firebaseSignup;
                  } else {
                    widget.loginType = LoginType.firebaseLogin;
                  }
                  _formKey.currentState.reset();
                }),
                child: (widget.loginType == LoginType.firebaseLogin) ? Text("Sign Up") : Text("Login"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _FormButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const _FormButton({Key key, this.onPressed, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 500,
      ),
      width: MediaQuery.of(context).size.width * .65,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .65,
          child: FlatButton(
            textColor: Colors.white,
            color: Colors.white.withOpacity(0.2),
            onPressed: this.onPressed,
            child: Text(
              this.text,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FormInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const _FormInput({
    Key key,
    @required this.controller,
    @required this.hintText,
    this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 500,
      ),
      width: MediaQuery.of(context).size.width * .65,
      child: TextFormField(
        controller: this.controller,
        obscureText: (this.obscureText != null) ? this.obscureText : false,
        cursorColor: Colors.white,
        keyboardType: TextInputType.text,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: this.hintText,
        ),
      ),
    );
  }
}
