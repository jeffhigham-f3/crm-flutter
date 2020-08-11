import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User with ChangeNotifier {
  static get currentUser async {
    return await FirebaseAuth.instance.currentUser();
  }
}
