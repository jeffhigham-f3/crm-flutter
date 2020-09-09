import 'package:meta/meta.dart';

class TrayUser {
  final String id;
  String accessToken;
  String authorizationCode;

  TrayUser({
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

  static final String createUserTokenSchema = r'''
mutation ($userId: ID!) {
  authorize(input: {
      userId: $userId
  }) {
    accessToken
  }
}
''';

  static final String createConfigWizardAuthorizationSchema = r'''
mutation ($userId: ID!) {
  generateAuthorizationCode( input: {
    userId: $userId
  }) {
    authorizationCode
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

  static final String deleteSchema = r'''
mutation($userInput: RemoveExternalUserInput!) {
  removeExternalUser(input: $userInput) {
      clientMutationId # REQUIRED - must specify as return field, not required to provide this in mutation function
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
