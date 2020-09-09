import 'package:flutter/foundation.dart';
import 'package:verb_crm_flutter/service/tray_io_service.dart';
import 'package:verb_crm_flutter/models/tray_io/tray_user.dart';
import 'package:verb_crm_flutter/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql/client.dart';
import 'dart:async';
import 'package:meta/meta.dart';

class TrayIOUserService extends TrayIOService {
  final _usersController = StreamController.broadcast();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Stream get stream => _usersController.stream;

  Future<void> readIndex() async {
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
  }

  Future<TrayUser> createUser({@required User appUser}) async {
    options = QueryOptions(documentNode: gql(TrayUser.createSchema), variables: <String, dynamic>{
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
    return user;
  }

  Future<TrayUser> currentUser() async {
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
    final user = TrayUser.fromTrayGraphQL(qlUser);
    print(user.toString());
    return user;
  }
}
