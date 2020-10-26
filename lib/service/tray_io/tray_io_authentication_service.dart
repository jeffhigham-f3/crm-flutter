import 'package:flutter/foundation.dart';
import 'package:verb_crm_flutter/service/tray_io/tray_io_service.dart';
import 'package:verb_crm_flutter/models/tray_io/import.dart';
import 'package:graphql/client.dart';
import 'dart:async';
import 'package:meta/meta.dart';

abstract class TrayIOAuthenticationServiceAbstract extends TrayIOService {
  /// Stream of TrayUsers
  Stream get stream;

  /// Future<List<TrayAuthentication>> getUserAuthentications({@required String accessToken}
  /// This query can be used to retrieve the authentications for a particular user.
  /// Reference:
  /// https://embedded-api-docs.tray.io/#6442068a-46ac-481e-87bb-339979f3bf29
  Future<List<TrayAuthentication>> getUserAuthentications({@required String accessToken});

  /// Future<TrayAuthentication> createAuthentication({@required TrayUser trayUser, @required TrayIOService service})
  /// Create a user authentication for a service (e.g. Dropbox or Airtable)
  /// that is used in your Embedded application. If your end user already has
  /// a login for a particular service, this endpoint allows you to input their
  /// authentication credentials in orderto avoid asking them to authenticate
  /// again, just because they want to use your Embedded application. These may
  /// be credentials for the Tray.io Connector for a service owned by you, and
  /// for which you already have access tokens, credentials, etc. It could also
  /// be for other third-party applications.
  /// Reference:
  /// https://embedded-api-docs.tray.io/#5ca04348-e496-483e-99ae-312ed4025940
  Future<TrayAuthentication> createAuthentication({@required String accessToken});

  /// Future<void> deleteAuthentication({@required String accessToken, @required TrayAuthentication authentication})
  /// Delete a user authentication
  /// Reference:
  /// https://embedded-api-docs.tray.io/#5ed6f5b2-9d7b-40df-afbb-1af38ff580cf
  Future<void> deleteAuthentication({@required String accessToken, @required TrayAuthentication authentication});
}

class TrayIOAuthenticationService extends TrayIOAuthenticationServiceAbstract {
  final _streamController = StreamController.broadcast();

  @override
  Stream get stream => _streamController.stream;

  @override
  Future<List<TrayAuthentication>> getUserAuthentications({@required String accessToken}) async {
    updateAccessToken(accessToken: accessToken);

    final options = QueryOptions(
      documentNode: gql(TrayAuthentication.indexSchema),
    );

    print('Sending user authentication index request to Tray.io');
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(
        result.exception.toString(),
      );
    }

    final List<dynamic> qlAuths = result.data['viewer']['authentications']['edges'] as List<dynamic>;

    List<TrayAuthentication> authentications = [];
    for (Map<String, dynamic> a in qlAuths) {
      print('Found Tray.io Authentication: ${a['node']}');
      authentications.add(
        TrayAuthentication.fromTrayGraphQL(a['node']),
      );
    }
    _streamController.sink.add(authentications);
    notifyListeners();
    return authentications;
  }

  @override
  Future<TrayAuthentication> createAuthentication({@required String accessToken}) async {
    updateAccessToken(accessToken: accessToken);

    final options = MutationOptions(
      documentNode: gql(TrayAuthentication.createSchema),
      variables: <String, dynamic>{
        // TODO: Implement these parameters with existing account
        'authenticationName': '',
        'serviceId': '',
        'serviceEnvironmentId': '',
        'authenticationData': '',
        'scopes': [],
        'hidden': false,
      },
    );

    print('Sending an authentication create request to Tray.io with: ${options.variables}');
    final QueryResult result = await client.mutate(options);
    if (result.hasException) {
      throw result.exception;
    }

    print("Create authentication result data is: ${result.data}");
    final Map<String, dynamic> qlAuth = result.data['createExternalUser'] as Map<String, dynamic>;
    final authentication = TrayAuthentication.fromTrayGraphQL(qlAuth);
    print('Created new Tray.io Authentication: ${authentication.toString()}');
    notifyListeners();
    return authentication;
  }

  @override
  Future<void> deleteAuthentication({@required String accessToken, @required TrayAuthentication authentication}) async {
    updateAccessToken(accessToken: accessToken);
    final options = MutationOptions(
      documentNode: gql(TrayUser.deleteSchema),
      variables: <String, dynamic>{
        'authenticationId': authentication.id,
      },
    );

    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      throw result.exception;
    }
    notifyListeners();
  }
}
