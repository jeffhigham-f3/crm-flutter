import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:verb_crm_flutter/models/user.dart';
import 'package:verb_crm_flutter/service/auth0_service.dart';

abstract class AuthServiceAbstract extends ChangeNotifier {
  User get currentUser;
  bool get isSignedIn;
  Future<User> loadCurrentUser();
  Future<AuthResult> firebaseAnonymous({@required String name, @required String email});
  Future<AuthResult> firebaseSignUp({@required String email, @required String password});
  Future<AuthResult> firebaseLogin({@required String email, @required String password});
  Future<void> Auth0Login();
  Future<void> signOut();
  String decodeError({@required exception});
}

class AuthService extends AuthServiceAbstract {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Auth0Service _auth0 = Auth0Service();
  User _currentUser;

  @override
  User get currentUser => _currentUser;

  @override
  bool get isSignedIn => _currentUser != null;

  Future<User> loadCurrentUser() async {
    final FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
    _currentUser = firebaseUser == null ? null : User.fromFirebase(firebaseUser);
    return _currentUser;
  }

  @override
  Future<AuthResult> firebaseAnonymous({@required String name, @required String email}) async {
    final AuthResult result = await _firebaseAuth.signInAnonymously();
    if (result?.user != null) {
      _currentUser = User.fromFirebase(result.user);
      notifyListeners();
    }
    return result;
  }

  @override
  Future<AuthResult> firebaseSignUp({@required String email, @required String password}) async {
    final AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    if (result?.user != null) {
      _currentUser = User.fromFirebase(result.user);
      notifyListeners();
    }
    return result;
  }

  @override
  Future<AuthResult> firebaseLogin({@required String email, @required String password}) async {
    final AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    if (result?.user != null) {
      _currentUser = User.fromFirebase(result.user);
      print('Login from: ${_currentUser.email}');
      notifyListeners();
    }
    return result;
  }

  @override
  Future<void> Auth0Login() async {
    final userDetails = await _auth0.loginAction();
    if (userDetails != null) {
      _currentUser = User.fromAuth0(userDetails);
      print('Login from: ${_currentUser.name}');
      notifyListeners();
    }
  }

  @override
  Future<void> signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
    ]);
    _currentUser = null;
    notifyListeners();
  }

  @override
  String decodeError({@required exception}) {
    switch (exception.code) {
      case "ERROR_ADMIN_RESTRICTED_OPERATION":
        return 'Anonymous accounts are not enabled';
        break;

      case "ERROR_WEAK_PASSWORD":
        return 'Your password is too weak';
        break;

      case "ERROR_WRONG_PASSWORD":
        return 'Your password is invalid or missing';
        break;

      case "ERROR_INVALID_EMAIL":
        return 'Your email is invalid or missing';
        break;

      case "ERROR_EMAIL_ALREADY_IN_USE":
        return 'The email address is already in use';
        break;

      case "ERROR_INVALID_CREDENTIAL":
        return 'Your email is invalid';
        break;

      case "authorize_and_exchange_code_failed":
        return 'Authorization failed';
        break;

      default:
        return 'Authentication failed';
    }
  }
}
