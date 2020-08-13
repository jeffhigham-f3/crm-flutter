import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/crm.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CrmLoginScreen extends StatefulWidget {
  static const String id = 'crm_login_screen';
  final Crm crm;

  const CrmLoginScreen({Key key, this.crm}) : super(key: key);

  @override
  _CrmLoginScreenState createState() => _CrmLoginScreenState();
}

class _CrmLoginScreenState extends State<CrmLoginScreen> {
  bool _saving = false;

  login() {
    setState(() {
      _saving = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _saving = false;
      });
      Navigator.pop(
        context,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
//    final CrmRouteArgs args = ModalRoute.of(context).settings.arguments;

    return ModalProgressHUD(
      inAsyncCall: _saving,
      child: Scaffold(
        body: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 86,
                height: 86,
                child: Image.asset('assets/${widget.crm.logo}'),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  widget.crm.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(
                height: 20,
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
                    widget.crm.enabled = true;
                    this.login();
                  }),
                  child: Text('${widget.crm.name} Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
