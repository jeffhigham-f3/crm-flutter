import 'package:verb_crm_flutter/models/contact.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

abstract class ContactServiceAbstract with ChangeNotifier {
  /// Stream of TraySolutionInstances
  Stream get stream;

  /// Future<List<Contact>> getContacts({@required String workflowUrl});
  /// Return contact records.
  Future<List<Contact>> getContacts({@required String workflowUrl});
}

class ContactService extends ContactServiceAbstract {
  final _controller = StreamController.broadcast();

  Stream get stream => _controller.stream;

  Future<List<Contact>> getContacts({@required String workflowUrl}) async {
    var response = await http.get(workflowUrl);
    print(response);
    final List<Contact> contacts = [];
    switch (response.statusCode) {
      case 200:
        {
          var jsonResponse = convert.jsonDecode(response.body);
          for (var c in jsonResponse) {
            contacts.add(Contact.fromJson(c));
          }
          _controller.sink.add(contacts);
        }
        break;

      default:
        _controller.sink.add([]);
        break;
    }
  }
}
