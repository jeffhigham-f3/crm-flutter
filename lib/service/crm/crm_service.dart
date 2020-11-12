import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:verb_crm_flutter/models/crm/import.dart';

final _firestore = FirebaseFirestore.instance;
final _firebaseController = _firestore.collection('crms');

abstract class CrmServiceAbstract with ChangeNotifier {
  List<Crm> get crms;
  void toggleState({Crm crm});
}

class CrmService extends CrmServiceAbstract {
  final _firebaseStream = _firebaseController.snapshots();
  final List<Crm> _crms = [];

  Comparator<Crm> _byName = (c1, c2) => c1.name.compareTo(c2.name);

  CrmService() {
    _firebaseStream.map((snapshot) => snapshot.docs).listen((crmData) {
      _crms.removeRange(0, _crms.length);
      for (var crm in crmData) {
        _crms.add(
          Crm.fromJson(crm.data()),
        );
      }
      _crms.sort(_byName);
      notifyListeners();
    }, onError: (err) {
      print(err);
    });
  }

  @override
  List<Crm> get crms => _crms;

  @override
  void toggleState({Crm crm}) {
    crm.enabled = !crm.enabled;
    notifyListeners();
  }
}
