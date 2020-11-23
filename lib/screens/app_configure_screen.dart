import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/app/import.dart';
import 'package:verb_crm_flutter/service/import.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppConfigureScreen extends StatefulWidget {
  final App app;
  AppConfigureScreen({Key key, this.app}) : super(key: key);
  @override
  _AppConfigureScreenState createState() => _AppConfigureScreenState();
}

class _AppConfigureScreenState extends State<AppConfigureScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final themeService = context.watch<ThemeService>();
    final appService = context.watch<AppService>();

    final List<Widget> content = [
      Container(
        width: MediaQuery.of(context).size.width,
        child: !widget.app.enabled
            ? Text(
                'Please login to ${widget.app.name} so you can begin configuring this integration!',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              )
            : Text(
                '${widget.app.name} Enabled!',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
      ),
      SizedBox(height: 20),
      OutlineButton(
        child: Text(
          widget.app.enabled ? 'Logout' : 'Login',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        onPressed: () {
          appService.toggleState(app: widget.app);
        },
      ),
      SizedBox(height: 20),
    ];

    widget.app.enabled
        ? widget.app.features.forEach((feature) {
            content.add(
              _AppFeatureOption(app: widget.app, feature: feature),
            );
          })
        : SizedBox.shrink();

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
                      tag: 'app-${widget.app.id}',
                      child: FaIcon(
                        widget.app.icon,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ])),
          ),
          SliverToBoxAdapter(
            child: AnimatedSize(
              vsync: this,
              duration: Duration(milliseconds: 100),
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
          ),
        ],
      ),
    );
  }
}

class _AppFeatureOption extends StatelessWidget {
  final App app;
  final AppFeature feature;
  const _AppFeatureOption({Key key, this.app, this.feature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appService = context.watch<AppService>();
    return Card(
      child: SwitchListTile(
        title: Text(feature.name),
        activeColor: Theme.of(context).accentColor,
        inactiveTrackColor: Theme.of(context).primaryColor.withOpacity(0.2),
        value: (app.enabled && feature.enabled),
        onChanged: (bool value) async {
          if (app.enabled) {
            feature.toggleEnabled();
            appService.notify();
          }
        },
        secondary: FaIcon(feature.icon),
      ),
    );
  }
}
