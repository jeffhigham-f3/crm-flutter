import 'package:verb_crm_flutter/service/tray_io_service.dart';
import 'package:verb_crm_flutter/models/tray_io/tray_solution_instance.dart';
import 'package:graphql/client.dart';
import 'dart:async';
import 'package:meta/meta.dart';

abstract class TrayIOSolutionInstanceServiceAbstract extends TrayIOService {
  /// Stream of TraySolutionInstances
  Stream get stream;

  /// Future<List<TraySolutionInstance>> getSolutionInstances({@required String accessToken,@required String ownerId})
  /// Return the Solution Instances associated with the user.
  /// Reference:
  /// https://embedded-api-docs.tray.io/#7e4ba537-fddc-410d-bd23-82b26d901d73
  Future<List<TraySolutionInstance>> getSolutionInstances({@required String accessToken, @required String ownerId});

  /// Future<void> enableSolutionInstance({@required String accessToken});
  /// Enable the Solution Instances associated with the user.
  Future<void> enableSolutionInstance({@required String accessToken, @required TraySolutionInstance instance});

  /// Future<void> disableSolutionInstance({@required String accessToken});
  /// Disable the Solution Instances associated with the user.
  Future<void> disableSolutionInstance({@required String accessToken, @required TraySolutionInstance instance});

  /// Future<void> deleteSolutionInstance({@required String accessToken});
  /// Disable the Solution Instances associated with the user.
  Future<void> deleteSolutionInstance({@required String accessToken, @required TraySolutionInstance instance});
}

class TrayIOSolutionInstanceService extends TrayIOSolutionInstanceServiceAbstract {
  final _servicesController = StreamController.broadcast();

  @override
  Stream get stream => _servicesController.stream;

  @override
  Future<List<TraySolutionInstance>> getSolutionInstances({
    @required String accessToken,
    @required String ownerId,
  }) async {
    updateAccessToken(accessToken: accessToken);

    final options = MutationOptions(
      documentNode: gql(TraySolutionInstance.indexSchema),
      variables: <String, String>{
        'ownerId': ownerId,
      },
    );

    print('TraySolutionInstance.getSolutionInstances: ${options.variables}');

    final QueryResult result = await client.mutate(options);

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

  @override
  Future<void> enableSolutionInstance({String accessToken, TraySolutionInstance instance}) async {
    updateAccessToken(accessToken: accessToken);
    final options = MutationOptions(
      documentNode: gql(TraySolutionInstance.updateSchema),
      variables: <String, dynamic>{
        'solutionInstanceId': instance.id,
        'instanceName': instance.name,
        'enabled': true,
      },
    );
    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      throw Exception(
        result.exception.toString(),
      );
    }
  }

  @override
  Future<void> disableSolutionInstance({String accessToken, TraySolutionInstance instance}) async {
    updateAccessToken(accessToken: accessToken);
    final options = MutationOptions(
      documentNode: gql(TraySolutionInstance.updateSchema),
      variables: <String, dynamic>{
        'solutionInstanceId': instance.id,
        'instanceName': instance.name,
        'enabled': false,
      },
    );
    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      throw Exception(
        result.exception.toString(),
      );
    }
  }

  @override
  Future<void> deleteSolutionInstance({String accessToken, TraySolutionInstance instance}) async {
    updateAccessToken(accessToken: accessToken);
    final options = MutationOptions(
      documentNode: gql(TraySolutionInstance.deleteSchema),
      variables: <String, dynamic>{'solutionInstanceId': instance.id},
    );
    print("deleteSolutionInstance - ${options.variables}");
    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      throw Exception(
        result.exception.toString(),
      );
    }
  }
}
