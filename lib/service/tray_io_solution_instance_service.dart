import 'package:verb_crm_flutter/service/tray_io_service.dart';
import 'package:verb_crm_flutter/models/tray_io/tray_solution_instance.dart';
import 'package:graphql/client.dart';
import 'dart:async';

abstract class TrayIOSolutionServiceAbstract extends TrayIOService {
  Stream get stream;
  Future<List<TraySolutionInstance>> readIndex();
}

class TrayIOSolutionService extends TrayIOSolutionServiceAbstract {
  final _servicesController = StreamController.broadcast();

  @override
  Stream get stream => _servicesController.stream;

  @override
  Future<List<TraySolutionInstance>> readIndex() async {
    final QueryOptions options = QueryOptions(
      documentNode: gql(TraySolutionInstance.readIndexSchema),
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(
        result.exception.toString(),
      );
    }

    final List<Object> qlSolutionInstances = result.data['viewer']['solutionInstances']['edges'] as List<Object>;

    List<TraySolutionInstance> instances = [];
    for (var s in qlSolutionInstances) {
      instances.add(
        TraySolutionInstance.fromTrayGraphQL(s),
      );
      print(instances.last.toString());
    }
    _servicesController.sink.add(instances);
    return instances;
  }
}
