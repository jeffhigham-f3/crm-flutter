import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/app/import.dart';

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
    return Card(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(left: 8, right: 12),
              width: MediaQuery.of(context).size.width * .25,
              child: Hero(
                tag: 'app-${widget.app.id}',
                child: Image.asset('assets/${widget.app.slug}.png'),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 18),
                    child: Text(
                      widget.app.name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 8,
                      bottom: 0,
                    ),
                    child: Text(widget.app.description, style: Theme.of(context).textTheme.bodyText1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlineButton(
                          child: Row(children: [
                            Text(
                              'Configure',
                              style: TextStyle(color: Theme.of(context).primaryColor),
                            )
                          ]),
                          onPressed: () => {
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
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
