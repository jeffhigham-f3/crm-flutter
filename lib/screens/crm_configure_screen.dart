import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/crm/import.dart';

class CrmConfigureScreen extends StatefulWidget {
  final Crm crm;

  const CrmConfigureScreen({Key key, this.crm}) : super(key: key);
  @override
  _CrmConfigureScreenState createState() => _CrmConfigureScreenState();
}

class _CrmConfigureScreenState extends State<CrmConfigureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            collapsedHeight: 150,
            expandedHeight: 150,
            flexibleSpace: Container(
                decoration: Palette.appBarGradientDecoration,
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.only(top: 55),
                    width: 120,
                    height: 120,
                    child: Hero(
                      tag: 'crm-${widget.crm.id}',
                      child: Image.asset(
                        'assets/${widget.crm.slug}.png',
                      ),
                    ),
                  ),
                ])),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Please login to ${widget.crm.name} so you can begin configuring this integration!',
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      OutlineButton(
                        child: Text(
                          'Authenticate',
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () => {
                          print("authenticating with ${widget.crm.name}"),
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                  CrmConfigOption(
                    title: 'People',
                    icon: Icons.contacts,
                  ),
                  CrmConfigOption(
                    title: 'Media',
                    icon: Icons.movie,
                  ),
                  CrmConfigOption(
                    title: 'Verb AI',
                    icon: Icons.dynamic_feed,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CrmConfigOption extends StatefulWidget {
  final String title;
  final IconData icon;

  const CrmConfigOption({Key key, this.title, this.icon}) : super(key: key);

  @override
  _CrmConfigOptionState createState() => _CrmConfigOptionState();
}

class _CrmConfigOptionState extends State<CrmConfigOption> {
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SwitchListTile(
        title: Text(widget.title),
        activeColor: Theme.of(context).accentColor,
        inactiveTrackColor: Theme.of(context).primaryColor.withOpacity(0.2),
        value: _enabled,
        onChanged: (bool value) {
          setState(() {
            _enabled = value;
          });
        },
        secondary: Icon(widget.icon),
      ),
    );
  }
}