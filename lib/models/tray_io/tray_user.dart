import 'package:meta/meta.dart';

class TrayUser {
  final String id;

  const TrayUser({
    @required this.id,
  });

  factory TrayUser.fromTrayGraphQL(Map<String, Object> user) {
    final Map<String, Object> node = user['node'];
    final id = node['id'];
    return TrayUser(
      id: id,
    );
  }

  @override
  String toString() => 'id: $id';

  static final String createSchema = r'''
mutation($externalUserId: String!, $name: String!) {
  createExternalUser(input: { name: $name, externalUserId: $externalUserId }) {
      userId
  }
}
''';

  static final String getSchema = r'''
query ($userId: String!){
    users(criteria: { userId: $userId }) {
        edges {
            node {
                name
                id
                externalUserId
            }
            cursor
        }
        pageInfo {
          hasNextPage
          endCursor
          hasPreviousPage
          startCursor
        }
	}
}
''';

  static final String readIndexSchema = r'''
query {
    users {
        edges {
            node {
                name
                id
                externalUserId
            }
            cursor
        }
        pageInfo {
          hasNextPage
          endCursor
          hasPreviousPage
          startCursor
        }
    }
}
''';
}
