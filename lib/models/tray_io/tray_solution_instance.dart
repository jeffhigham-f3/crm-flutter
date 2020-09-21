import 'package:meta/meta.dart';

class TraySolutionInstance {
  final String id;
  final String name;
  final bool enabled;
  final String owner;
  final String created;
  final Map<String, bool> solutionVersionFlags;
  final List<Map<String, dynamic>> workflows;
  final Map<String, String> authValues;
  final Map<String, String> configValues;
  final String cursor;
  final Map<String, dynamic> pageInfo;

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
    final Map<String, Object> node = solutionInstance['node'];

    return TraySolutionInstance(
      id: node['id'],
      name: node['name'],
      enabled: node['enabled'],
      owner: node['owner'],
      created: node['created'],
      solutionVersionFlags: node['solutionVersionFlags'],
      workflows: node['workflows'],
      authValues: node['authValues'],
      configValues: node['configValues'],
      cursor: node['cursor'],
      pageInfo: node['pageInfo'],
    );
  }

  @override
  String toString() => 'id: $id, name: $name, enabled: $enabled, owner: $owner';

  static final String readIndexSchema = r'''
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
}
