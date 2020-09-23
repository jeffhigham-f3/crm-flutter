import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:verb_crm_flutter/secure_constants.dart';
import 'package:verb_crm_flutter/models/tray_io/tray_solution.dart';
import 'package:verb_crm_flutter/models/tray_io/tray_user.dart';
import 'package:verb_crm_flutter/service/tray_io_solution_service.dart';
import 'package:verb_crm_flutter/service/tray_io_user_service.dart';
import 'package:provider/provider.dart';

class SolutionAuthScreen extends StatelessWidget {
  static const String id = 'solution_auth_screen';
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  final TraySolution solution;
  SolutionAuthScreen({Key key, this.solution}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trayIOUserService = context.watch<TrayIOUserService>();

    return Scaffold(
      appBar: AppBar(
        title: Text(solution.title),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          trayIOUserService.createUserToken().then((accessToken) {
            trayIOUserService.createConfigWizardAuthorization().then((authorizationCode) {
//              final url = '$kTrayIOEmbedAPIUrl/external/solutions/$kTrayIOPartnerName/configure/${solution.id}?code=$authorizationCode';
//              final Map<String, String> headers = {'Authorization': 'Bearer $accessToken'};
//              print('Loading URL: $url with headers: $headers');
//              webViewController.loadUrl(url, headers: headers);
              webViewController.loadUrl('https://tray-embeded.f3code.io');
              _controller.complete(webViewController);
            }).catchError((e) {
              print(e.toString());
            });
          }).catchError((e) {
            print(e.toString());
          });
        },
      ),
    );
  }
}
