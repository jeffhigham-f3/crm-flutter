import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:verb_crm_flutter/models/user/user.dart';
import 'package:verb_crm_flutter/service/auth/auth0_service.dart';

abstract class AuthServiceAbstract extends ChangeNotifier {
  User get currentUser;
  bool get isSignedIn;
  Future<User> loadCurrentUser();
  Future<auth.UserCredential> firebaseAnonymous({@required String name, @required String email});
  Future<auth.UserCredential> firebaseSignUp({@required String email, @required String password});
  Future<auth.UserCredential> firebaseLogin({@required String email, @required String password});
  Future<void> auth0Login();
  Future<void> signOut();
  String decodeError({@required exception});
}

class AuthService extends AuthServiceAbstract {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final Auth0Service _auth0 = Auth0Service.instance;
  User _currentUser;

  @override
  User get currentUser => _currentUser;

  @override
  bool get isSignedIn => _currentUser != null;

  Future<User> loadCurrentUser() async {
    final auth.User firebaseUser = _firebaseAuth.currentUser;
    final Object auth0User = await _auth0.currentUser();
    if (firebaseUser != null) {
      print("User is from Firebase");
      _currentUser = User.fromFirebase(firebaseUser);
    } else if (auth0User != null) {
      print("User is from Auth0");
      _currentUser = User.fromAuth0(auth0User);
    } else {
      return null;
    }
    print(_currentUser);
    return _currentUser;
  }

  @override
  Future<auth.UserCredential> firebaseAnonymous({@required String name, @required String email}) async {
    final auth.UserCredential result = await _firebaseAuth.signInAnonymously();
    if (result?.user != null) {
      _currentUser = User.fromFirebase(result.user);
      notifyListeners();
    }
    return result;
  }

  @override
  Future<auth.UserCredential> firebaseSignUp({@required String email, @required String password}) async {
    final auth.UserCredential result =
        await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    if (result?.user != null) {
      print("Firebase User");
      print(result.user);
      _currentUser = User.fromFirebase(result.user);
      notifyListeners();
    }
    return result;
  }

  @override
  Future<auth.UserCredential> firebaseLogin({@required String email, @required String password}) async {
    final auth.UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    if (result?.user != null) {
      _currentUser = User.fromFirebase(result.user);
      notifyListeners();
    }
    return result;
  }

  @override
  Future<void> auth0Login() async {
    final userDetails = await _auth0.loginAction();
    if (userDetails != null) {
      _currentUser = User.fromAuth0(userDetails);
      print('Auth0 login from: ${_currentUser.name}');
      notifyListeners();
    }
  }

  @override
  Future<void> signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
    ]);
    await _auth0.logoutAction();
    _currentUser = null;
    notifyListeners();
  }

  @override
  String decodeError({@required exception}) {
//    if (exception is Exception) {
    return exception.toString();
//    }

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
