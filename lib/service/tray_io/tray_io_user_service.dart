import 'package:flutter/foundation.dart';
import 'package:verb_crm_flutter/service/tray_io/tray_io_service.dart';
import 'package:verb_crm_flutter/models/tray_io/import.dart';
import 'package:verb_crm_flutter/models/user/user.dart';
import 'package:graphql/client.dart';
import 'dart:async';
import 'package:meta/meta.dart';

abstract class TrayIOUserServiceAbstract extends TrayIOService {
  /// Active TrayUser
  TrayUser get currentUser;

  /// Stream of TrayUsers
  Stream get stream;

  /// Future<List<TrayUser>> getUsers()
  /// Get all users including their name, id, and externalUserId.
  /// Reference:
  /// https://embedded-api-docs.tray.io/#f5b00818-c195-4637-adba-d3be6fcba185
  Future<List<TrayUser>> getUsers();

  /// Future<TrayUser> createUser()
  /// Create a new external user of your Embedded application.
  /// Reference:
  /// https://embedded-api-docs.tray.io/#068585a8-521d-4f04-b101-c91226cf2747
  Future<TrayUser> createUser();

  /// Future<String> createUserToken()
  /// A user token allows access to the APIs which require a user token (Create Solution Instance,
  /// Get Solution Instances, Create User Auth etc.) and should be passed as a Bearer in the Authorization
  /// header when calling those APIs.
  /// Note: This access token expires after 2 days.
  /// Reference:
  /// https://embedded-api-docs.tray.io/#79a5484c-65d3-4181-89df-875c7f2c3ebb
  Future<String> createUserToken();

  /// Future<String> createConfigWizardAuthorization()
  /// Creates an authorization code for allowing a user to access the Configuration Wizard
  /// which enables them to authenticate with the services included in your Embedded
  /// application, as well as enter any other Config Data you may require of them.
  /// Note: This is a one-time use code which expires after 5 minutes.
  /// Used in request to:
  /// https://embedded.tray.io/external/solutions/${partnerId}/configure/${solutionInstanceId}?code=${authorizationCode}
  /// Reference:
  /// https://embedded-api-docs.tray.io/#35b36670-c570-4fe2-adb5-55a34658ccab
  Future<String> createConfigWizardAuthorization();

  /// Future<TrayUser> loadCurrentUser()
  /// Get user by externalUserId (specified by our app when we create the user)
  /// Creates a new TrayUser if one does not already exist.
  /// Reference:
  /// https://embedded-api-docs.tray.io/#f5b00818-c195-4637-adba-d3be6fcba185
  Future<TrayUser> loadCurrentUser();

  /// Future<TrayUser> deleteUser()
  /// This mutation is used to delete an external user from your Embedded application.
  /// Note: Deleting a user will also disable and delete all Solution Instances associated with that user.
  /// Reference:
  /// https://embedded-api-docs.tray.io/#6a79fc79-c3a5-4b46-ae05-84c605b85c59
  Future<void> deleteUser();
}

class TrayIOUserService extends TrayIOUserServiceAbstract {
  final _streamController = StreamController.broadcast();

  TrayUser _currentUser;

  @override
  TrayUser get currentUser => _currentUser;

  @override
  Stream get stream => _streamController.stream;

  @override
  Future<List<TrayUser>> getUsers() async {
    final options = QueryOptions(
      documentNode: gql(TrayUser.indexSchema),
    );
    print('Sending user index request to Tray.io');
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(
        result.exception.toString(),
      );
    }

    final List<dynamic> qlUsers = result.data['users']['edges'] as List<dynamic>;

    List<TrayUser> users = [];
    for (Map<String, dynamic> u in qlUsers) {
      print('Found Tray.io User: ${u['node']}');
      users.add(
        TrayUser.fromTrayGraphQL(u['node']),
      );
    }
    _streamController.sink.add(users);
    notifyListeners();
    return users;
  }

  @override
  Future<TrayUser> createUser({@required User appUser}) async {
    final options = MutationOptions(
      documentNode: gql(TrayUser.createSchema),
      variables: <String, dynamic>{
        'name': '${appUser.name}',
        'externalUserId': '${appUser.id}',
      },
    );
    print('Sending user create request to Tray.io with: ${options.variables}');
    final QueryResult result = await client.mutate(options);
    if (result.hasException) {
      throw result.exception;
    }

    print("Create user result data is: ${result.data}");
    final Map<String, dynamic> qlUser = result.data['createExternalUser'] as Map<String, dynamic>;
    final userOptions = qlUser
      ..addAll(options.variables)
      ..addAll({'id': qlUser['userId']})
      ..remove('userId');
    final user = TrayUser.fromTrayGraphQL(userOptions);
    print('Created new Tray.io User: ${user.toString()}');
    notifyListeners();
    return user;
  }

  @override
  Future<String> createUserToken() async {
    // TODO: Check for existing token and refresh. Currently we generate a new one every time.
    final options = MutationOptions(
      documentNode: gql(TrayUser.createUserTokenSchema),
      variables: <String, dynamic>{
        'userId': _currentUser.id,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      throw result.exception;
    }

    final String accessToken = result.data['authorize']['accessToken'] as String;
    _currentUser.accessToken = accessToken;
    notifyListeners();
    return accessToken;
  }

  @override
  Future<String> createConfigWizardAuthorization() async {
    final options = MutationOptions(
      documentNode: gql(TrayUser.createConfigWizardAuthorizationSchema),
      variables: <String, dynamic>{
        'userId': _currentUser.id,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      throw result.exception;
    }

    final String authCode = result.data['generateAuthorizationCode']['authorizationCode'] as String;
    _currentUser.authorizationCode = authCode;
    notifyListeners();
    return authCode;
  }

  @override
  Future<TrayUser> loadCurrentUser({@required String externalUserId}) async {
    if (externalUserId == null) {
      return null;
    }
    final options = QueryOptions(
      documentNode: gql(TrayUser.getSchema),
      variables: <String, dynamic>{
        'userCriteria': {
          'externalUserId': externalUserId,
        }
      },
    );
    print('Sending user find request to Tray.io for: ${options.variables}');
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(
        result.exception.toString(),
      );
    }
    final edges = result.data['users']['edges'] as List<dynamic>;
    if (edges.length >= 1) {
      // TODO: explore cases where multiple users would be associated with the same externalUserId.
      final Object qlUser = edges.first['node'] as Object;
      print('Found Tray.io User: $qlUser');
      _currentUser = TrayUser.fromTrayGraphQL(qlUser);
      notifyListeners();
      return _currentUser;
    }

    return null;
  }

  @override
  Future<void> deleteUser() async {
    final options = MutationOptions(documentNode: gql(TrayUser.deleteSchema), variables: <String, dynamic>{
      'userInput': _currentUser.id,
    });

    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      throw result.exception;
    }
    _currentUser = null;
    notifyListeners();
    getUsers();
  }
}
