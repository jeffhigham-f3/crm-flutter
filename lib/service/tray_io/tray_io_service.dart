import 'package:verb_crm_flutter/config/secure_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

class TrayIOService with ChangeNotifier {
  HttpLink httpLink;
  AuthLink authLink;
  Link link;
  GraphQLClient client;

  TrayIOService() {
    httpLink = HttpLink(uri: kTrayIOGraphQlUrl);
    updateAccessToken(accessToken: kTrayIOMasterToken);
  }

  void updateAccessToken({@required String accessToken}) {
    authLink = AuthLink(getToken: () async => 'Bearer $accessToken');
    link = this.authLink.concat(this.httpLink);
    client = GraphQLClient(cache: InMemoryCache(), link: link);
  }
}
