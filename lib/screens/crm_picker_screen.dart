import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:verb_crm_flutter/screens/crm_login_screen.dart';

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
          flex: 5,
          child: CustomScrollView(
            primary: false,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: UniversalPlatform.isWeb ? 4 : 2,
                  children: <Widget>[
                    CrmTile(
                      title: "Salesforce",
                    ),
                    CrmTile(
                      title: "Hubspot",
                    ),
                    CrmTile(
                      title: "Netsuite",
                    ),
                    CrmTile(
                      title: "Verb CRM",
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: RaisedButton(
              child: Text("Complete Setup!"),
              onPressed: () => {},
            ),
          ),
        )
      ],
    );
  }
}

class CrmTile extends StatefulWidget {
  final String title;
  bool configured = false;

  CrmTile({Key key, @required this.title}) : super(key: key);

  @override
  _CrmTileState createState() => _CrmTileState();
}

class _CrmTileState extends State<CrmTile> {
  configure() {
    setState(
      () {
        widget.configured = true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.configured) {
      return Container(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.business_center),
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              RaisedButton(
                child: Icon(
                  Icons.done,
                  color: Colors.green,
                ),
                disabledColor: Colors.grey[300],
                onPressed: null,
              )
            ],
          ),
        ),
        color: Colors.grey[100],
      );
    } else {
      return Container(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.business_center),
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              RaisedButton(
                child: Text("Configure"),
                onPressed: () => {
                  Navigator.pushNamed(
                    context,
                    CrmLoginScreen.id,
                  ),
                  configure(),
                },
              )
            ],
          ),
        ),
        color: Colors.grey[100],
      );
    }
  }
}
