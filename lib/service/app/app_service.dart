import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verb_crm_flutter/app/import.dart';
import 'package:verb_crm_flutter/models/app/import.dart';

final _firestore = FirebaseFirestore.instance;
final _firebaseController = _firestore.collection('crms');

abstract class AppServiceAbstract with ChangeNotifier {
  List<App> get apps;
  void toggleState({App app});
}

class AppService extends AppServiceAbstract {
  // final _firebaseStream = _firebaseController.snapshots();
  final List<App> _apps = [];

  Comparator<App> _byName = (a1, a2) => a1.name.compareTo(a2.name);

  AppService() {
    // _firebaseStream.map((snapshot) => snapshot.docs).listen((appData) {
    //   _apps.removeRange(0, _apps.length);
    //   for (var app in appData) {
    //     _apps.add(
    //       App.fromFirestore(app.data()),
    //     );
    //   }
    //   _apps.sort(_byName);
    //   notifyListeners();
    // }, onError: (err) {
    //   print(err);
    // });

    kAppInstances.forEach((instance) {
      _apps.add(App.fromConfig(instance));
    });
    notifyListeners();
  }

  @override
  List<App> get apps => _apps;

  @override
  void toggleState({App app}) {
    app.enabled = !app.enabled;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}
