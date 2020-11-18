import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/app/import.dart';
import 'package:verb_crm_flutter/service/import.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppConfigureScreen extends StatelessWidget {
  final App app;
  AppConfigureScreen({Key key, this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeService = context.watch<ThemeService>();
    final contactService = context.watch<ContactService>();

    final List<Widget> content = [
      Text(
        'Please login to ${app.name} so you can begin configuring this integration!',
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
          print("authenticating with ${app.name}"),
        },
      ),
      SizedBox(height: 20),
    ];

    app.features.forEach((feature) {
      content.add(
        _AppFeatureOption(feature: feature),
      );
    });

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
                      tag: 'app-${app.id}',
                      child: Image.asset(
                        'assets/${app.slug}.png',
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
                    children: content,
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

class _AppFeatureOption extends StatelessWidget {
  final AppFeature feature;
  const _AppFeatureOption({Key key, this.feature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appService = context.watch<AppService>();
    return Card(
      child: SwitchListTile(
        title: Text(feature.name),
        activeColor: Theme.of(context).accentColor,
        inactiveTrackColor: Theme.of(context).primaryColor.withOpacity(0.2),
        value: feature.enabled,
        onChanged: (bool value) async {
          await feature.toggleEnabled();
          await appService.notify();
        },
        secondary: FaIcon(feature.icon),
      ),
    );
  }
}
