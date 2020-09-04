import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/tray_io/tray_solution.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SolutionAuthScreen extends StatefulWidget {
  static const String id = 'solution_auth_screen';
  final TraySolution solution;

  const SolutionAuthScreen({Key key, this.solution}) : super(key: key);

  @override
  _SolutionAuthScreenState createState() => _SolutionAuthScreenState();
}

class _SolutionAuthScreenState extends State<SolutionAuthScreen> {
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
//    final TraySolutionRouteArgs args = ModalRoute.of(context).settings.arguments;

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
                child: Image.asset('assets/${widget.solution.title}.png'),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  widget.solution.title,
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
                    widget.solution.enabled = true;
                    this.login();
                  }),
                  child: Text('${widget.solution.title} Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
