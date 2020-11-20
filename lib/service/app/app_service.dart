import 'package:flutter/foundation.dart';
import 'package:verb_crm_flutter/app/import.dart';
import 'package:verb_crm_flutter/models/app/import.dart';

abstract class AppServiceAbstract with ChangeNotifier {
  List<App> get apps;
  void toggleState({App app});
}

class AppService extends AppServiceAbstract {
  final List<App> _apps = [];
  Comparator<App> _byName = (a1, a2) => a1.name.compareTo(a2.name);

  AppService() {
    kAppInstances.forEach((instance) {
      _apps.add(App.fromConfig(instance));
    });
    _apps.sort(_byName);
    notifyListeners();
  }

  @override
  List<App> get apps => _apps;

  @override
  void toggleState({App app}) {
    app.enabled = !app.enabled;
    notifyListeners();
  }

  List<App> enabledApps() {
    return apps.where((a) => a.enabled).toList();
  }

  bool hasEnabledApps() {
    return enabledApps().length > 0;
  }
}
