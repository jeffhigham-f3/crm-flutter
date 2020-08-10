import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/crm.dart';
import 'package:verb_crm_flutter/screens/crm_picker_screen.dart';

class CrmLoginScreen extends StatelessWidget {
  static const String id = 'crm_login_screen';

  @override
  Widget build(BuildContext context) {
    final CrmRouteArgs args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 86,
              height: 86,
              child: args.crm.logoSvg,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                args.crm.name,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .65,
              child: TextFormField(
                decoration: const InputDecoration(hintText: "Username"),
                keyboardType: TextInputType.text,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .65,
              child: TextFormField(
                decoration: const InputDecoration(hintText: "Password"),
                obscureText: true,
                keyboardType: TextInputType.text,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: OutlineButton(
                onPressed: (() {
                  args.crm.toggleEnabled();
                  Navigator.pop(
                    context,
                    CrmPickerScreen.id,
                  );
                }),
                child: Text('${args.crm.name} Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
