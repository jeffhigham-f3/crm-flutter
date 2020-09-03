import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/secure_constants.dart';
import 'package:verb_crm_flutter/models/tray_io/tray_solution.dart';
import 'dart:async';
import 'package:graphql/client.dart';

class TrayIOService with ChangeNotifier {
  final TrayIOSolutionServiceAbstract streamService = TrayIOSolutionService();
}

abstract class TrayIOSolutionServiceAbstract {}

class TrayIOSolutionService extends TrayIOSolutionServiceAbstract {
  final _servicesController = StreamController.broadcast();

  Stream get stream => _servicesController.stream;

  TrayIOSolutionService() {
    _servicesController.sink.add(
      index(),
    );
  }

  Future<Object> index() async {
    final HttpLink _httpLink = HttpLink(
      uri: kTrayIOGraphQlUrl,
    );

    final AuthLink _authLink = AuthLink(
      getToken: () async => 'Bearer $kTrayIOMasterToken',
    );

    final Link _link = _authLink.concat(_httpLink);

    final GraphQLClient _client = GraphQLClient(
      cache: InMemoryCache(),
      link: _link,
    );

    final QueryOptions options = QueryOptions(
      documentNode: gql(TraySolution.readIndexSchema),
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      throw Exception(
        result.exception.toString(),
      );
    }
    final List<dynamic> services = result.data['viewer']['solutions']['edges'] as List<dynamic>;
    print("Tray.io Solutions:");
    print(services.toString());
    print('');
    return services;
  }
}
