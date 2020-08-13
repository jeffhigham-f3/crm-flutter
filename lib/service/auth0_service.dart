import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String AUTH0_DOMAIN = 'jeffhigham-dev.us.auth0.com';
const String AUTH0_CLIENT_ID = '6kk42nzkDApAG1G4pSAPI71GtugWhXGV';

const String AUTH0_REDIRECT_URI = 'com.auth0.flutterdemo://login-callback';
const String AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';

abstract class Auth0ServiceAbstract {}

class Auth0Service extends Auth0ServiceAbstract {
  final FlutterAppAuth appAuth = FlutterAppAuth();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<Map<String, dynamic>> loginAction() async {
    final AuthorizationTokenResponse result = await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        AUTH0_CLIENT_ID,
        AUTH0_REDIRECT_URI,
        issuer: 'https://$AUTH0_DOMAIN',
        scopes: <String>['openid', 'profile', 'offline_access'],
      ),
    );
    final Map<String, dynamic> idToken = parseIdToken(result.idToken);
    final Map<String, dynamic> userDetails = await getUserDetails(result.accessToken);
    await secureStorage.write(key: 'refresh_token', value: result.refreshToken);
    print('idToken: $idToken, userDetails: $userDetails');
    return userDetails;
  }

  Map<String, Object> parseIdToken(String idToken) {
    final List<String> parts = idToken.split('.');
    assert(parts.length == 3);

    return jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  Future<Map<String, Object>> getUserDetails(String accessToken) async {
    final String url = 'https://jeffhigham-dev.us.auth0.com/userinfo';
    final http.Response response = await http.get(
      url,
      headers: <String, String>{'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final rawUser = jsonDecode(response.body);
      return rawUser;
    } else {
      throw Exception('Failed to get user details');
    }
  }

  Future<void> logoutAction() async {
    await secureStorage.delete(key: 'refresh_token');
  }

  Future<void> initAction() async {
    final String storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    if (storedRefreshToken == null) return;

    try {
      final TokenResponse response = await appAuth.token(TokenRequest(
        AUTH0_CLIENT_ID,
        AUTH0_REDIRECT_URI,
        issuer: AUTH0_ISSUER,
        refreshToken: storedRefreshToken,
      ));

      final Map<String, Object> idToken = parseIdToken(response.idToken);
      final Map<String, Object> profile = await getUserDetails(response.accessToken);

      await secureStorage.write(key: 'refresh_token', value: response.refreshToken);
    } on Exception catch (e, s) {
      debugPrint('error on refresh token: $e - stack: $s');
      await logoutAction();
    }
  }
}
