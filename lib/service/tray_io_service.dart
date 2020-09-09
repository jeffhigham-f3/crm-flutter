import 'package:verb_crm_flutter/secure_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

class TrayIOService with ChangeNotifier {
  HttpLink httpLink;
  AuthLink authLink;
  Link link;
  GraphQLClient client;
  QueryOptions options;

  TrayIOService() {
    httpLink = HttpLink(uri: kTrayIOGraphQlUrl);
    authLink = AuthLink(getToken: () async => 'Bearer $kTrayIOMasterToken');
    client = GraphQLClient(cache: InMemoryCache(), link: link);
    link = authLink.concat(httpLink);
  }
}
