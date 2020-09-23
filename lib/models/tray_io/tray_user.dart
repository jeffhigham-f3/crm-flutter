import 'package:meta/meta.dart';

class TrayUser {
  final String name;
  final String id;
  final String externalUserId;

  String accessToken;
  String authorizationCode;

  TrayUser({
    @required this.name,
    @required this.id,
    @required this.externalUserId,
  });

  factory TrayUser.fromTrayGraphQL(Map<String, dynamic> userParams) {
    print('Instantiating a new TrayUser with: $userParams');
    return TrayUser(
      name: userParams['name'],
      id: userParams['id'],
      externalUserId: userParams['externalUserId'],
    );
  }

  @override
  String toString() =>
      'name: ${this.name},\nid: ${this.id},\nexternalUserId: ${this.externalUserId},\naccessToken: ${this.accessToken}';

  static final String indexSchema = r'''
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

  static final String createSchema = r'''
mutation($externalUserId: String!, $name: String!) {
  createExternalUser(input: { name: $name, externalUserId: $externalUserId }) {
      userId
  }
}
''';

  static final String getSchema = r'''
query ($userCriteria: UserSearchCriteria){
    users (criteria: $userCriteria){
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
}
