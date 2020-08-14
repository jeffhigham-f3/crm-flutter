import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verb_crm_flutter/screens/crm_login_screen.dart';
import 'package:verb_crm_flutter/screens/app_home.dart';
import 'package:verb_crm_flutter/models/crm.dart';
import 'package:verb_crm_flutter/models/crm_manager.dart';

class CrmPickerScreen extends StatelessWidget {
  static const String id = 'crm_picker_screen';

  final bool modal;
  const CrmPickerScreen({Key key, this.modal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CrmCardGrid(
        modal: this.modal,
      ),
    );
  }
}

class CrmCardGrid extends StatelessWidget {
  final bool modal;

  const CrmCardGrid({Key key, this.modal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final crmManager = context.watch<CrmManager>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              "Which CRM should we connect to?",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
            ),
            padding: const EdgeInsets.all(20),
            itemCount: crmManager.entities.length,
            itemBuilder: (BuildContext context, int index) {
              return CrmCard(
                crm: crmManager.entities[index],
              );
            },
          ),
        ),
        Expanded(
          child: Center(
            child: OutlineButton(
              child: Text("Continue"),
              onPressed: (() {
                (this.modal != null && this.modal)
                    ? Navigator.pop(context)
                    : Navigator.pushReplacementNamed(
                        context,
                        AppHome.id,
                      );
              }),
            ),
          ),
        )
      ],
    );
  }
}

class CrmCard extends StatefulWidget {
  final Crm crm;
  CrmCard({Key key, @required this.crm}) : super(key: key);

  @override
  _CrmCardState createState() => _CrmCardState();
}

class _CrmCardState extends State<CrmCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              child: Image.asset('assets/${widget.crm.logo}'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              widget.crm.name,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: 10.0,
            ),
            (widget.crm.enabled)
                ? Icon(
                    Icons.done,
                  )
                : OutlineButton(
                    child: Text("Connect"),
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CrmLoginScreen(crm: widget.crm),
                            fullscreenDialog: true,
                          )).then(
                        (value) => {
                          setState(() {}),
                          Scaffold.of(context).showSnackBar(
                            new SnackBar(
                              content: Text(
                                '${widget.crm.name} Connected!',
                                style: Theme.of(context).textTheme.subtitle2,
                                textAlign: TextAlign.center,
                              ),
                              duration: Duration(seconds: 1),
                              backgroundColor: Theme.of(context).accentColor,
                            ),
                          )
                        },
                      )
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
