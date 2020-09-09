import 'package:flutter/foundation.dart';
import 'package:verb_crm_flutter/service/tray_io_service.dart';
import 'package:verb_crm_flutter/models/tray_io/tray_user.dart';
import 'package:verb_crm_flutter/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  TrayUser _currentUser;

  @override
  TrayIOUserService() {
    loadCurrentUser();
  }

  @override
  TrayUser get currentUser => _currentUser;

  @override
  Stream get stream => _usersController.stream;

  @override
  Future<TrayUser> createUser({@required User appUser}) async {
    final mutationOptions = MutationOptions(
        documentNode: gql(TrayUser.createSchema),
        variables: <String, dynamic>{
          'externalUserId': appUser.id.toString(),
          'name': appUser.name.toString(),
        });

    final QueryResult result = await client.mutate(mutationOptions);

    if (result.hasException) {
      throw result.exception;
    }

    final Object qlUser = result.data['createExternalUser'] as Object;
    final user = TrayUser.fromTrayGraphQL(qlUser);
    print('Setting the "tray_user_id" value to: ${user.id}');
    await _secureStorage.write(key: 'tray_user_id', value: user.id);
    print(user.toString());
    readIndex();
    notifyListeners();
    return user;
  }

  @override
  Future<String> createUserToken() async {
    final mutationOptions = MutationOptions(
        documentNode: gql(TrayUser.createUserTokenSchema),
        variables: <String, dynamic>{
          'userId': _currentUser.id,
        });

    final QueryResult result = await client.mutate(mutationOptions);

    if (result.hasException) {
      throw result.exception;
    }

    final String accessToken =
        result.data['authorize']['accessToken'] as String;
    print('Setting the "tray_user_token" value to: $accessToken');
    await _secureStorage.write(key: 'tray_access_token', value: accessToken);
    _currentUser.accessToken = accessToken;
    notifyListeners();
    return accessToken;
  }

  @override
  Future<String> createConfigWizardAuthorization() async {
    final mutationOptions = MutationOptions(
        documentNode: gql(TrayUser.createConfigWizardAuthorizationSchema),
        variables: <String, dynamic>{
          'userId': _currentUser.id,
        });

    final QueryResult result = await client.mutate(mutationOptions);

    if (result.hasException) {
      throw result.exception;
    }

    final String authCode =
        result.data['authorize']['authorizationCode'] as String;
    print('Setting the "tray_authorization_code" value to: $authCode');
    await _secureStorage.write(key: 'tray_authorization_code', value: authCode);
    _currentUser.authorizationCode = authCode;
    notifyListeners();
    return authCode;
  }

  @override
  Future<TrayUser> loadCurrentUser() async {
    final String userId = await _secureStorage.read(key: 'tray_user_id');
    if (userId == null) {
      print('"tray_user_id" not found in local cache.');
      return null;
    }

    options = QueryOptions(
      documentNode: gql(TrayUser.getSchema),
      variables: <String, dynamic>{
        'userId': userId,
      },
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(
        result.exception.toString(),
      );
    }

    final Object qlUser = result.data['users']['edges']['node'] as Object;
    // TODO: GraphQL API will return status 200 with an empty list if the user is not found. Check for an empty list before assigning.
    _currentUser = TrayUser.fromTrayGraphQL(qlUser);
    print("User is from Tray.io");
    print(_currentUser.toString());
    notifyListeners();
    return _currentUser;
  }

  @override
  Future<void> deleteUser() async {
    final mutationOptions = MutationOptions(
        documentNode: gql(TrayUser.deleteSchema),
        variables: <String, dynamic>{
          'userInput': _currentUser.id,
        });

    final QueryResult result = await client.mutate(mutationOptions);

    if (result.hasException) {
      throw result.exception;
    }

    await _secureStorage.delete(key: 'tray_user_id');
    await _secureStorage.delete(key: 'tray_user_token');
    await _secureStorage.delete(key: 'tray_authorization_code');
    _currentUser = null;
    notifyListeners();
    readIndex();
  }

  @override
  Future<List<TrayUser>> readIndex() async {
    options = QueryOptions(
      documentNode: gql(TrayUser.readIndexSchema),
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(
        result.exception.toString(),
      );
    }

    final List<Object> qlUsers = result.data['users']['edges'] as List<Object>;

    List<TrayUser> users = [];
    for (var u in qlUsers) {
      users.add(
        TrayUser.fromTrayGraphQL(u),
      );
      print(users.last.toString());
    }
    _usersController.sink.add(users);
    notifyListeners();
    return users;
  }
}
