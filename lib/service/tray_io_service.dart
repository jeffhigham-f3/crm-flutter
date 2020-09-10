import 'package:verb_crm_flutter/secure_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

class TrayIOService with ChangeNotifier {
  HttpLink httpLink;
  AuthLink authLink;
  Link link;
  GraphQLClient client;

  TrayIOService() {
    httpLink = HttpLink(uri: kTrayIOGraphQlUrl);
    authLink = AuthLink(getToken: () async => 'Bearer $kTrayIOMasterToken');
    link = authLink.concat(httpLink);
    client = GraphQLClient(cache: InMemoryCache(), link: link);
  }
}
