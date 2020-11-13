import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/crm/import.dart';
import 'package:provider/provider.dart';

class CrmWidget extends StatefulWidget {
  final Crm crm;
  const CrmWidget({Key key, this.crm}) : super(key: key);

  @override
  _CrmWidgetState createState() => _CrmWidgetState();
}

class _CrmWidgetState extends State<CrmWidget> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final crmService = context.watch<CrmService>();
    return Card(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(left: 8, right: 12),
                width: MediaQuery.of(context).size.width * .25,
                child: Hero(
                  tag: 'crm-${widget.crm.id}',
                  child: Image.asset('assets/${widget.crm.slug}.png'),
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
                        widget.crm.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: 0,
                      ),
                      child: Text(widget.crm.description, style: Theme.of(context).textTheme.bodyText1),
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
                                  builder: (context) => CrmConfigureScreen(
                                    crm: widget.crm,
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
        ]));
  }
}
