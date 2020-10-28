import 'package:verb_crm_flutter/service/tray_io/tray_io_service.dart';
import 'package:verb_crm_flutter/models/tray_io/import.dart';
import 'package:graphql/client.dart';
import 'dart:async';
import 'package:meta/meta.dart';

abstract class TrayIOSolutionServiceAbstract extends TrayIOService {
  /// Stream of TraySolutionInstances
  Stream get stream;

  /// TraySolutionInstances
  List<TraySolution> solutions;

  /// Future<List<TraySolution>> getSolutions({@required String accessToken,@required String ownerId})
  /// Return the Solution Instances associated with the user.
  /// Reference:
  /// https://embedded-api-docs.tray.io/#896e9587-a3ac-487e-989b-4b24d06a01d0
  Future<List<TraySolution>> getSolutionInstances({@required String accessToken});
}

class TrayIOSolutionService extends TrayIOSolutionServiceAbstract {
  final _servicesController = StreamController.broadcast();
  final List<TraySolution> _solutions = [];

  @override
  List<TraySolution> get solutions => _solutions;

  @override
  Stream get stream => _servicesController.stream;

  @override
  Future<List<TraySolution>> getSolutionInstances({@required String accessToken}) async {
    updateAccessToken(accessToken: accessToken);

    final QueryOptions options = QueryOptions(
      documentNode: gql(TraySolution.readIndexSchema),
    );
    print('TrayIOSolutionService.readIndex: ${options.variables}');

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(
        result.exception.toString(),
      );
    }

    final List<Object> qlSolutions = result.data['viewer']['solutions']['edges'] as List<Object>;
    this._solutions.removeRange(0, this._solutions.length);
    for (var s in qlSolutions) {
      _solutions.add(
        TraySolution.fromTrayGraphQL(s),
      );
    }
    _servicesController.sink.add(_solutions);
    notifyListeners();
    return _solutions;
  }
}
