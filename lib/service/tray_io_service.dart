import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/secure_constants.dart';
import 'package:verb_crm_flutter/models/tray_io/tray_solution.dart';
import 'dart:async';
import 'package:graphql/client.dart';

class TrayIOService with ChangeNotifier {
  final TrayIOSolutionService solutionService = TrayIOSolutionService();
}

class TrayIOSolutionService {
  final _servicesController = StreamController.broadcast();

  Stream get stream => _servicesController.stream;

  Future<Object> readIndex() async {
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

    final List<Object> graphQlSolutions = result.data['viewer']['solutions']['edges'] as List<Object>;

    List<TraySolution> solutions = [];
    for (var s in graphQlSolutions) {
      solutions.add(
        TraySolution.fromTrayGraphQL(s),
      );
      print(solutions.last.toString());
    }
    _servicesController.sink.add(solutions);
  }
}
