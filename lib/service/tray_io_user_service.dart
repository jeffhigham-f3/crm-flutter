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
  Future<TrayUser> loadCurrentUser();
  Future<List<TrayUser>> readIndex();
}

class TrayIOUserService extends TrayIOUserServiceAbstract {
  final _usersController = StreamController.broadcast();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  TrayUser _currentUser;

  TrayIOUserService() {
    loadCurrentUser();
  }

  @override
  TrayUser get currentUser => _currentUser;

  @override
  Stream get stream => _usersController.stream;

  @override
  Future<TrayUser> createUser({@required User appUser}) async {
    options = QueryOptions(
        documentNode: gql(TrayUser.createSchema),
        variables: <String, dynamic>{
          'externalUserId': appUser.id,
          'name': appUser.name,
        });

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(
        result.exception.toString(),
      );
    }

    final Object qlUser = result.data['createExternalUser'] as Object;
    final user = TrayUser.fromTrayGraphQL(qlUser);
    await _secureStorage.write(key: 'tray_user_id', value: user.id);
    print(user.toString());
    readIndex();
    notifyListeners();
    return user;
  }

  @override
  Future<TrayUser> loadCurrentUser() async {
    final String userId = await _secureStorage.read(key: 'tray_user_id');
    if (userId == null) {
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
    print(_currentUser.toString());
    notifyListeners();
    return _currentUser;
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
