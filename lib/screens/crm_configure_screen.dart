import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/crm/import.dart';
import 'package:verb_crm_flutter/service/import.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CrmConfigureScreen extends StatelessWidget {
  final Crm crm;

  const CrmConfigureScreen({Key key, this.crm}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeService = context.watch<ThemeService>();

    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            collapsedHeight: 150,
            expandedHeight: 150,
            flexibleSpace: Container(
                decoration: themeService.appBarGradientDecoration,
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.only(top: 55),
                    width: 120,
                    height: 120,
                    child: Hero(
                      tag: 'crm-${crm.id}',
                      child: Image.asset(
                        'assets/${crm.slug}.png',
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
                        'Please login to ${crm.name} so you can begin configuring this integration!',
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
                          print("authenticating with ${crm.name}"),
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                  _CrmConfigOption(
                    title: 'People',
                    icon: FontAwesomeIcons.addressBook,
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

class _CrmConfigOption extends StatefulWidget {
  final String title;
  final IconData icon;

  const _CrmConfigOption({Key key, this.title, this.icon}) : super(key: key);

  @override
  __CrmConfigOptionState createState() => __CrmConfigOptionState();
}

class __CrmConfigOptionState extends State<_CrmConfigOption> {
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
        secondary: FaIcon(widget.icon),
      ),
    );
  }
}
