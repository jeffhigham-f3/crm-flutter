import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:verb_crm_flutter/models/tray_io/import.dart';

abstract class TrayIOWorkflowServiceAbstract extends ChangeNotifier {
  /// Stream of Workflows
  Stream get stream;

  /// Active Workflow Config
  List<TrayWorkflow> get workflows;

  /// Future<List<TrayWorkflow>> getWorkFlows()
  Future<List<TrayWorkflow>> getWorkFlows();

  /// Future TrayWorkflow getWorkflow({@required String uuid});
  Future<TrayWorkflow> getWorkflow({String uuid});
}

class TrayIOWorkflowService extends TrayIOWorkflowServiceAbstract {
  final _streamController = StreamController.broadcast();

  List<TrayWorkflow> _workflows;
  @override
  Stream get stream => _streamController.stream;

  @override
  List<TrayWorkflow> get workflows => _workflows;

  @override
  Future<TrayWorkflow> getWorkflow({String uuid}) async {
    return this._workflows.firstWhere((workflow) => workflow.uuid == uuid);
  }

  @override
  Future<List<TrayWorkflow>> getWorkFlows() async {
    this._workflows.add(
          TrayWorkflow(
              uuid: '7eb3a98b-db27-4523-a84d-3ce971d854d2',
              title: 'Salesforce Contacts Index',
              description: 'Index of contacts',
              slug: 'salesforce-contacts-index'),
        );
    this._streamController.sink.add(this._workflows);
    notifyListeners();
    return this._workflows;
  }
}
