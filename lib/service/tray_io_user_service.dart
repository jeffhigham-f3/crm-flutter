import 'package:flutter/foundation.dart';
import 'package:verb_crm_flutter/service/tray_io_service.dart';
import 'package:verb_crm_flutter/models/tray_io/tray_user.dart';
import 'package:verb_crm_flutter/models/user.dart';
import 'package:graphql/client.dart';
import 'dart:async';
import 'package:meta/meta.dart';

abstract class TrayIOUserServiceAbstract extends TrayIOService {
  TrayUser get currentUser;
  Stream get stream;
  Future<TrayUser> createUser();
  Future<String> createUserToken();
  Future<String> createConfigWizardAuthorization();
  Future<TrayUser> loadCurrentUser();
  Future<void> deleteUser();
  Future<List<TrayUser>> readIndex();
}

class TrayIOUserService extends TrayIOUserServiceAbstract {
  final _usersController = StreamController.broadcast();

  TrayUser _currentUser;

  @override
  TrayUser get currentUser => _currentUser;

  @override
  Stream get stream => _usersController.stream;

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
    final options = MutationOptions(documentNode: gql(TrayUser.createUserTokenSchema), variables: <String, dynamic>{
      'userId': _currentUser.id,
    });

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
    final options =
        MutationOptions(documentNode: gql(TrayUser.createConfigWizardAuthorizationSchema), variables: <String, dynamic>{
      'userId': _currentUser.id,
    });

    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      throw result.exception;
    }

    final String authCode = result.data['authorize']['authorizationCode'] as String;
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
    readIndex();
  }

  @override
  Future<List<TrayUser>> readIndex() async {
    final options = QueryOptions(
      documentNode: gql(TrayUser.readIndexSchema),
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
    _usersController.sink.add(users);
    notifyListeners();
    return users;
  }
}
