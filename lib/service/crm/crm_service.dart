import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:verb_crm_flutter/models/crm/import.dart';
import 'dart:async';

final _firestore = FirebaseFirestore.instance;
final _firebaseController = _firestore.collection('crms');

abstract class CrmServiceAbstract with ChangeNotifier {
  Stream get stream;
}

class CrmService extends CrmServiceAbstract {
  final _controller = StreamController.broadcast();
  final _firebaseStream = _firebaseController.snapshots();
  final List<Crm> _crms = [];

  Comparator<Crm> _byName = (c1, c2) => c1.name.compareTo(c2.name);

  CrmService() {
    _firebaseStream.map((snapshot) => snapshot.docs).listen((crmData) {
      _crms.removeRange(0, _crms.length);
      for (var crm in crmData) {
        _crms.add(
          Crm.fromJson(
            crm.data(),
          ),
        );
      }
      _crms.sort(_byName);
      _controller.sink.add(_crms);
      notifyListeners();
      return _crms;
    }, onError: (err) {
      print(err);
    });
  }

  @override
  Stream get stream => _controller.stream;

  Future<List<Crm>> refreshAll() async {
    if (_crms.isEmpty) {
      return null;
    }
    // await Future.delayed(const Duration(milliseconds: 5));
    print(_crms);
    _controller.sink.add(_crms);
    notifyListeners();
    return _crms;
  }

  Future<void> toggleState({@required Crm crm}) {
    crm.enabled = !crm.enabled;
    refreshAll();
  }
}
