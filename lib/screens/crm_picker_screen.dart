import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:verb_crm_flutter/screens/crm_login_screen.dart';
import 'package:verb_crm_flutter/screens/crm_app_home.dart';
import 'package:verb_crm_flutter/models/crm.dart';
import 'package:verb_crm_flutter/models/crm_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CrmPickerScreen extends StatelessWidget {
  static const String id = 'crm_picker_screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NewWidget(),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            itemCount: Provider.of<CrmManager>(context, listen: true).entities.length,
            itemBuilder: (BuildContext context, int index) {
              return CrmCard(
                crm: Provider.of<CrmManager>(context, listen: false).entities[index],
              );
            },
          ),
        ),
        Expanded(
          child: Center(
            child: RaisedButton(
              child: Text("Let's Get Selling!"),
              onPressed: () => {
                Navigator.pushReplacementNamed(
                  context,
                  CrmAppHome.id,
                ),
              },
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
  configure() {
    setState(
      () {
        widget.crm.enabled = true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String assetName = 'assets/${widget.crm.logo}';
    final Widget logoWidget = SvgPicture.asset(
      assetName,
      semanticsLabel: widget.crm.name,
    );

    return Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 42,
              height: 42,
              child: logoWidget,
            ),
            Text(
              widget.crm.name,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            (widget.crm.enabled)
                ? Icon(
                    Icons.done,
                  )
                : RaisedButton(
                    child: Text("Configure"),
                    onPressed: () => {
                      Navigator.pushNamed(
                        context,
                        CrmLoginScreen.id,
                      ),
                      configure(),
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
