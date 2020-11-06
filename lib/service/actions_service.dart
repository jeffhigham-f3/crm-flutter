import 'package:flutter/material.dart';

abstract class ActionsServiceAbstract with ChangeNotifier {
  List<Widget> get actions;
  Widget get title;
  Future<void> setActions({List<Widget> actions});
  Future<void> setTitle({Widget title});
  Future<void> notify();
}

class ActionsService extends ActionsServiceAbstract {
  List<Widget> _actions = [];
  Widget _title = Text('Verb');
  @override
  List<Widget> get actions => _actions;
  @override
  Widget get title => _title;

  @override
  Future<void> setActions({List<Widget> actions}) async {
    this._actions = actions;
  }

  @override
  Future<void> setTitle({Widget title}) async {
    this._title = title;
  }

  @override
  Future<void> notify() async {
    Future.delayed(Duration.zero, () async {
      notifyListeners();
    });
  }
}
