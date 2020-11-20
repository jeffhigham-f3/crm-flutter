import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/app/import.dart';
import 'package:verb_crm_flutter/contact/import.dart';

class AppWidget extends StatefulWidget {
  final App app;
  const AppWidget({Key key, this.app}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    IconData icon;
    if (widget.app.enabled) {
      icon = (widget.app.hasActiveFeatures()) ? FontAwesomeIcons.checkCircle : FontAwesomeIcons.exclamation;
    } else {
      icon = FontAwesomeIcons.cog;
    }
    return Card(
      child: InkWell(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppConfigureScreen(
                app: widget.app,
              ),
              fullscreenDialog: true,
            ),
          )
        },
        splashColor: Theme.of(context).accentColor.withOpacity(0.1),
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Hero(
              tag: 'app-${widget.app.id}',
              child: FaIcon(
                widget.app.icon,
                size: 36,
              ),
            ),
          ),
          title: Text(widget.app.name),
          subtitle: Text(widget.app.description),
          enabled: true,
          trailing: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: FaIcon(icon, size: 28),
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
