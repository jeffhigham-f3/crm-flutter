import 'package:meta/meta.dart';

class TrayAuthentication {
  final String name;
  final String id;
  final Map<String, dynamic> service;

  TrayAuthentication({
    @required this.name,
    @required this.id,
    @required this.service,
  });

  factory TrayAuthentication.fromTrayGraphQL(Map<String, dynamic> authParams) {
    print('Instantiating a new TrayAuthentication with: $authParams');
    return TrayAuthentication(
      name: authParams['name'],
      id: authParams['id'],
      service: authParams['service'],
    );
  }

  @override
  String toString() => 'name: ${this.name},\nid: ${this.id},\service: ${this.service}';

  static final String indexSchema = r'''
query {
  viewer {
    authentications {
      edges {
        node {
          id
          name
          customFields
          service {
            id,
            name,
            icon,
            title,
            version
          }
          serviceEnvironment {
              id
              title
          }
        }
      }
      pageInfo{
        hasNextPage
        hasPreviousPage
      }
    }
  }
}
''';

  static final String createSchema = r'''
mutation (
    $authenticationName: String!,
    $serviceId: String!,
    $serviceEnvironmentId: String!,
    $authenticationData: Json!,
    $hidden: Boolean!
    ){ createUserAuthentication (input:{
            name: $authenticationName,
            serviceId: $serviceId,
            serviceEnvironmentId: $serviceEnvironmentId,
            data: $authenticationData,
            scopes: [],
            hidden: $hidden
      }) {
    authenticationId
  }
}
''';

  static final String deleteSchema = r'''
mutation ($authenticationId: ID!){
  removeAuthentication(input: { authenticationId: $authenticationId }) {
    clientMutationId
  }
}
''';
}
