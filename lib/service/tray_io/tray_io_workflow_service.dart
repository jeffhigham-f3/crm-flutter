import 'package:verb_crm_flutter/models/tray_io/import.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

abstract class TrayIOWorkflowServiceAbstract with ChangeNotifier {
  Stream get stream;
  List<TrayWorkflow> get workflows;
  Future<TrayWorkflow> getWorkFlowById({String id});
  Future<TrayWorkflow> getWorkFlowBySlug({String slug});
  Future<List<TrayWorkflow>> getWorkFlows();
}

class TrayIOWorkflowService extends TrayIOWorkflowServiceAbstract {
  final _controller = StreamController.broadcast();
  final List<TrayWorkflow> _workflows = [];

  TrayIOWorkflowService() {
    this.getWorkFlows();
  }

  @override
  List<TrayWorkflow> get workflows => _workflows;

  @override
  Stream get stream => _controller.stream;

  @override
  Future<TrayWorkflow> getWorkFlowById({String id}) async {
    return this._workflows.firstWhere((workflow) => workflow.id == id);
  }

  @override
  Future<TrayWorkflow> getWorkFlowBySlug({String slug}) async {
    return this._workflows.firstWhere((workflow) => workflow.slug == slug);
  }

  @override
  Future<List<TrayWorkflow>> getWorkFlows() async {
    await Future.delayed(const Duration(milliseconds: 5));
    this._workflows.removeRange(0, this._workflows.length);
    _workflows.add(
      TrayWorkflow(
        id: '7eb3a98b-db27-4523-a84d-3ce971d854d2',
        title: 'Salesforce Contacts Index',
        description: 'Index of Salesforce contacts',
        slug: 'salesforce-contacts-index',
      ),
    );
    _workflows.add(
      TrayWorkflow(
        id: '7c1793d1-c77e-4d69-9a60-f2be8967a1b1',
        title: 'Hubspot Contacts Index',
        description: 'Index of Hubspot contacts',
        slug: 'hubspot-contacts-index',
      ),
    );
    _controller.sink.add(_workflows);
    notifyListeners();
    return this._workflows;
  }
}
