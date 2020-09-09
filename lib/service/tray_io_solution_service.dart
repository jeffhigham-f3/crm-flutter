import 'package:verb_crm_flutter/service/tray_io_service.dart';
import 'package:verb_crm_flutter/models/tray_io/tray_solution.dart';
import 'package:graphql/client.dart';
import 'dart:async';

class TrayIOSolutionService extends TrayIOService {
  final _servicesController = StreamController.broadcast();

  Stream get stream => _servicesController.stream;

  Future<void> readIndex() async {
    final QueryOptions options = QueryOptions(
      documentNode: gql(TraySolution.readIndexSchema),
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(
        result.exception.toString(),
      );
    }

    final List<Object> qlSolutions = result.data['viewer']['solutions']['edges'] as List<Object>;

    List<TraySolution> solutions = [];
    for (var s in qlSolutions) {
      solutions.add(
        TraySolution.fromTrayGraphQL(s),
      );
      print(solutions.last.toString());
    }
    _servicesController.sink.add(solutions);
  }
}
