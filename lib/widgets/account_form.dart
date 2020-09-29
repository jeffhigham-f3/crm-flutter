import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/screens/app_home.dart';
import 'package:verb_crm_flutter/enums/import.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/service/auth_service.dart';
import 'package:verb_crm_flutter/service/tray_io_user_service.dart';
import 'package:verb_crm_flutter/service/tray_io_solution_instance_service.dart';

class AccountFormForm extends StatefulWidget {
  LoginType loginType;

  AccountFormForm({Key key, @required this.loginType}) : super(key: key);

  @override
  _AccountFormFormState createState() => _AccountFormFormState();
}

class _AccountFormFormState extends State<AccountFormForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();

    return Form(
      key: _formKey,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxHeight: 320,
          minHeight: 320,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            (widget.loginType == LoginType.firebaseSignup)
                ? _FormInput(
                    hintText: "Name",
                    obscureText: false,
                    controller: _nameController,
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  )
                : SizedBox.shrink(),
            _FormInput(
              hintText: "Email address",
              controller: _emailController,
              icon: Icon(
                Icons.email,
                color: Colors.white,
              ),
            ),
            _FormInput(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,
              icon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            _FormButton(
              text: (widget.loginType == LoginType.firebaseLogin) ? "LOGIN" : "SIGNUP",
              onPressed: () {
                final email = _emailController.text;
                final password = _passwordController.text;
                _formKey.currentState.reset();

                if (widget.loginType == LoginType.firebaseLogin) {
                  authService
                      .firebaseLogin(email: email, password: password)
                      .then((result) => _loadState())
                      .catchError((e) => _onLoginError(e));
                } else {
                  authService
                      .firebaseSignUp(email: email, password: password)
                      .then((result) => _loadState())
                      .catchError((e) => _onLoginError(e));
                }
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '- OR -',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Sign in with',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: 250,
                minHeight: 40,
              ),
              width: MediaQuery.of(context).size.width * .65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => authService
                        .auth0Login()
                        .then(
                          (result) => _loadState(),
                        )
                        .catchError((e) => _onLoginError(e)),
                    child: Container(
                      height: 48.0,
                      width: 48.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/google.jpg',
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => authService
                        .auth0Login()
                        .then(
                          (result) => _loadState(),
                        )
                        .catchError((e) => _onLoginError(e)),
                    child: Container(
                      height: 48.0,
                      width: 48.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/facebook.jpg',
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => authService
                        .auth0Login()
                        .then(
                          (result) => _loadState(),
                        )
                        .catchError((e) => _onLoginError(e)),
                    child: Container(
                      height: 48.0,
                      width: 48.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/auth0_logo.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadState() async {
    final authService = context.read<AuthService>();
    final trayUserService = context.read<TrayIOUserService>();
    final traySolutionInstanceService = context.read<TrayIOSolutionInstanceService>();

    authService.loadCurrentUser().then(
      (user) {
        if (user != null) {
          trayUserService.loadCurrentUser(externalUserId: user.id).then(
            (trayUser) {
              if (trayUser == null) {
                trayUserService.createUser(appUser: user).then((trayUser) {
                  trayUserService.createUserToken().then(
                    (accessToken) {
                      traySolutionInstanceService
                          .getSolutionInstances(accessToken: trayUser.accessToken, ownerId: trayUser.id)
                          .catchError((e) => {print(e)});
                      _onUserSuccess(user);
                    },
                  ).catchError((e) => {print(e)});
                }).catchError((e) => _onLoginError(e));
              } else {
                trayUserService.createUserToken().then(
                  (accessToken) {
                    traySolutionInstanceService
                        .getSolutionInstances(accessToken: trayUser.accessToken, ownerId: trayUser.id)
                        .catchError((e) => {print(e)});
                    _onUserSuccess(user);
                  },
                ).catchError((e) => {print(e)});
              }
            },
          ).catchError((e) => _onLoginError(e));
        }
      },
    ).catchError((e) => _onLoginError(e));
  }

  void _onLoginError(dynamic error) {
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

  void _onUserSuccess(dynamic result) {
    Navigator.pushReplacementNamed(
      context,
      AppHome.id,
    );
  }
}

//class _SecondaryButton extends StatelessWidget {
//  final Function onPressed;
//  final String text;
//
//  const _SecondaryButton({Key key, this.onPressed, this.text})
//      : super(key: key);
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: FlatButton(
//        onPressed: this.onPressed,
//        child: Text(
//          this.text,
//          style: TextStyle(
//            color: Colors.white,
//            fontSize: 14.0,
//          ),
//        ),
//      ),
//    );
//  }
//}

class _FormButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const _FormButton({Key key, this.onPressed, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 500,
        minHeight: 40,
      ),
      width: MediaQuery.of(context).size.width * .65,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: this.onPressed,
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          this.text,
          style: TextStyle(
            color: Theme.of(context).accentColor,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
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
  final Icon icon;

  const _FormInput({
    Key key,
    @required this.controller,
    @required this.hintText,
    this.icon,
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
          fontSize: 22.0,
        ),
        decoration: InputDecoration(
          hintText: this.hintText,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.white54,
            fontSize: 22.0,
          ),
          prefixIcon: this.icon,
        ),
      ),
    );
  }
}
