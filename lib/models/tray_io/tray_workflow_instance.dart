import 'package:meta/meta.dart';

class TrayWorkflowInstance {
  final String triggerUrl;
  final String id;
  final String sourceWorkflowId;

  TrayWorkflowInstance({@required this.triggerUrl, @required this.id, @required this.sourceWorkflowId});

  factory TrayWorkflowInstance.fromTrayGraphQL(Map<String, dynamic> instance) {
    final Map<String, dynamic> node = instance['node'];
    return TrayWorkflowInstance(
      triggerUrl: node['triggerUrl'],
      id: node['id'],
      sourceWorkflowId: node['sourceWorkflowId'],
    );
  }

  @override
  String toString() => 'triggerUrl: $triggerUrl, id: $id, sourceWorkflowId: $sourceWorkflowId';
}
