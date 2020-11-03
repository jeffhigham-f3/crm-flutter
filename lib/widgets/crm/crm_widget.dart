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
  final List<CrmFeatureWidget> features = [];

  @override
  void initState() {
    widget.crm.features.forEach((feature) {
      features.add(
        CrmFeatureWidget(feature: feature),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final crmService = context.watch<CrmService>();
    return AnimatedSize(
      vsync: this,
      duration: Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      child: Card(
        shadowColor: widget.crm.enabled ? Colors.green : null,
        elevation: widget.crm.enabled ? 2.0 : 0.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(left: 8, right: 12),
              width: MediaQuery.of(context).size.width * .25,
              child: Image.asset('assets/${widget.crm.slug}.png'),
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
                  widget.crm.enabled
                      ? Container(
                          padding: EdgeInsets.only(
                            top: 8,
                            bottom: 0,
                          ),
                          child: Wrap(
                            spacing: 3.0,
                            children: features,
                          ),
                        )
                      : SizedBox.shrink(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.crm.enabled
                          ? FlatButton(
                              child: Row(children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Active',
                                  style: TextStyle(color: Colors.green),
                                )
                              ]),
                              onPressed: () => {crmService.toggleState(crm: widget.crm)},
                            )
                          : FlatButton(
                              child: Text('Inactive'), onPressed: () => {crmService.toggleState(crm: widget.crm)}),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
