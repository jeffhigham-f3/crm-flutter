import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/goal_picker_screen.dart';
import 'package:verb_crm_flutter/enums/import.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/service/auth_service.dart';

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

  @override
  void initState() {
    super.initState();
    _loadState();
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            SizedBox(
              height: 20.0,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _SecondaryButton(
                  onPressed: () => setState(() {
                    if (widget.loginType == LoginType.firebaseLogin) {
                      widget.loginType = LoginType.firebaseSignup;
                    } else {
                      widget.loginType = LoginType.firebaseLogin;
                    }
                    _formKey.currentState.reset();
                  }),
                  text: (widget.loginType == LoginType.firebaseLogin) ? 'Sign Up' : 'Login',
                ),
                Container(
                  color: Colors.white.withOpacity(0.5),
                  width: 1,
                  height: 10,
                ),
                _SecondaryButton(
                  onPressed: () => authService.Auth0Login()
                      .then(
                        (result) => _onSuccess(null),
                      )
                      .catchError(
                        (e) => _onError(e),
                      ),
                  text: 'Auth0',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadState() async {
    context.read<AuthService>().loadCurrentUser().then(
      (user) {
        if (user != null) {
          _onSuccess(user);
        }
      },
    ).catchError(
      (e) => _onError(e),
    );
  }

  void _onError(dynamic error) {
    print(error);
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

  void _onSuccess(dynamic result) {
    Navigator.pushReplacementNamed(
      context,
      GoalPickerScreen.id,
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const _SecondaryButton({Key key, this.onPressed, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: this.onPressed,
        child: Text(
          this.text,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 14.0,
          ),
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
    return InkWell(
      onTap: this.onPressed,
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(
          maxWidth: 500,
          minHeight: 40,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: Colors.white.withOpacity(0.2),
        ),
        width: MediaQuery.of(context).size.width * .65,
        child: Text(
          this.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
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
        cursorColor: Colors.white.withOpacity(0.2),
        keyboardType: TextInputType.text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          hintText: this.hintText,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.2),
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }
}
