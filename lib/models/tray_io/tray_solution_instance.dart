import 'package:meta/meta.dart';
import 'package:verb_crm_flutter/models/tray_io/tray_workflow_instance.dart';

class TraySolutionInstance {
  final String id;
  final String name;
  final bool enabled;
  final String owner;
  final String created;
  final dynamic solutionVersionFlags;
  final List<TrayWorkflowInstance> workflows;
  final dynamic authValues;
  final dynamic configValues;
  final String cursor;
  final dynamic pageInfo;

  TraySolutionInstance({
    @required this.id,
    @required this.name,
    @required this.enabled,
    @required this.owner,
    @required this.created,
    @required this.solutionVersionFlags,
    @required this.workflows,
    @required this.authValues,
    @required this.configValues,
    @required this.cursor,
    @required this.pageInfo,
  });

  factory TraySolutionInstance.fromTrayGraphQL(Map<String, dynamic> solutionInstance) {
    final Map<String, dynamic> node = solutionInstance['node'];

    List<TrayWorkflowInstance> workFlows = [];
    for (var flow in node['workflows']['edges']) {
      workFlows.add(TrayWorkflowInstance.fromTrayGraphQL(flow));
    }
    return TraySolutionInstance(
      id: node['id'],
      name: node['name'],
      enabled: node['enabled'],
      owner: node['owner'],
      created: node['created'],
      solutionVersionFlags: node['solutionVersionFlags'],
      workflows: workFlows,
      authValues: node['authValues'],
      configValues: node['configValues'],
      cursor: node['cursor'],
      pageInfo: node['pageInfo'],
    );
  }

  @override
  String toString() => 'TraySolutionInstance - id: $id, name: $name, enabled: $enabled, owner: $owner';

  static final String indexSchema = r'''
query ($ownerId: String!){
	viewer {
		solutionInstances(criteria: { owner: $ownerId }) {
			edges {
				node {
					id
					name
					enabled
					owner
					created
					solutionVersionFlags {
						hasNewerVersion
						requiresUserInputToUpdateVersion
						requiresSystemInputToUpdateVersion
					}
					workflows {
						edges {
							node {
								triggerUrl
								id
								sourceWorkflowId
							}
						}
					}
					authValues {
						externalId
						authId
					}
					configValues {
						externalId
						value
					}
				}
				cursor
			}
			pageInfo {
				startCursor
				endCursor
				hasNextPage
				hasPreviousPage
			}
		}
	}
}
''';

  static final String updateSchema = r'''
mutation($solutionInstanceId: ID!, $instanceName: String!, $enabled: Boolean!) {
    updateSolutionInstance(
    input: { 
      solutionInstanceId: $solutionInstanceId, 
      instanceName: $instanceName,
      enabled: $enabled 
    }){
      solutionInstance {
        id
        name
        enabled
        created
      }
    }
  }
''';

  static final String deleteSchema = r'''
mutation($solutionInstanceId: ID!) {
  removeSolutionInstance(
  input: {
      solutionInstanceId: $solutionInstanceId
  }) {
   clientMutationId
 }
}
''';
}
