import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:verb_crm_flutter/secure_constants.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//https://auth0.com/blog/get-started-with-flutter-authentication/
// Web support: https://github.com/MaikuB/flutter_appauth/issues/70
abstract class Auth0ServiceAbstract {}

class Auth0Service extends Auth0ServiceAbstract {
  final FlutterAppAuth appAuth = FlutterAppAuth();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<Object> currentUser() async {
    final String storedRefreshToken =
        await secureStorage.read(key: 'refresh_token');
    if (storedRefreshToken == null) {
      return null;
    }

    final TokenResponse response = await appAuth.token(
      TokenRequest(
        kAuth0ClientId,
        kAuth0RedirectUri,
        issuer: 'https://$kAuth0Domain',
        refreshToken: storedRefreshToken,
      ),
    );

//    final Map<String, dynamic> idToken = _parseIdToken(response.idToken);
    final Map<String, dynamic> userDetails =
        await _getUserDetails(response.accessToken);
    final Map<String, dynamic> privateUserDetails =
        await _getUserPrivateDetails(sub: userDetails['sub']);
    print(privateUserDetails);
    await secureStorage.write(
        key: 'refresh_token', value: response.refreshToken);
    return userDetails;
  }

  Future<Object> loginAction() async {
    final AuthorizationTokenResponse response =
        await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        kAuth0ClientId,
        kAuth0RedirectUri,
        issuer: 'https://$kAuth0Domain',
        scopes: <String>[
          'openid',
          'profile',
          'email',
          'offline_access',
          'api',
        ],
      ),
    );
//    final Map<String, Object> idToken = _parseIdToken(response.idToken);
    final Map<String, Object> userDetails =
        await _getUserDetails(response.accessToken);
    final Map<String, dynamic> privateUserDetails =
        await _getUserPrivateDetails(sub: userDetails['sub']);
    print(privateUserDetails);
    await secureStorage.write(
        key: 'refresh_token', value: response.refreshToken);
    return userDetails;
  }

//  Map<String, Object> _parseIdToken(String idToken) {
//    final List<String> parts = idToken.split('.');
//    assert(parts.length == 3);
//
//    return jsonDecode(
//        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
//  }

  Future<Map<String, Object>> _getUserDetails(String accessToken) async {
    final String url = 'https://$kAuth0Domain/userinfo';
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

  Future<Map<String, Object>> _getUserPrivateDetails(
      {String accessToken, String sub}) async {
    final String tokenUrl = 'https://$kAuth0BackEndDomain/oauth/token';
    final http.Response tokenResponse = await http.post(
      tokenUrl,
      body: {
        'grant_type': 'client_credentials',
        'client_id': kAuth0BackEndClientId,
        'client_secret': kAuth0BackEndClientSecret,
        'audience': 'https://$kAuth0BackEndDomain/api/v2/',
      },
    );

    final accessToken = jsonDecode(tokenResponse.body)['access_token'];

    final String url = 'https://$kAuth0BackEndDomain/api/v2/users/$sub';
    final http.Response response = await http.get(
      url,
      headers: <String, String>{'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.body);
      throw Exception(response);
    }
  }

  Future<void> logoutAction() async {
    await secureStorage.delete(key: 'refresh_token');
  }
}
