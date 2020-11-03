import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/crm/import.dart';

class CrmFeatureWidget extends StatefulWidget {
  final CrmFeature feature;

  CrmFeatureWidget({Key key, this.feature}) : super(key: key);

  @override
  _CrmFeatureWidgetState createState() => _CrmFeatureWidgetState();
}

class _CrmFeatureWidgetState extends State<CrmFeatureWidget> {
  @override
  Widget build(BuildContext context) {
    return ActionChip(
      backgroundColor: Theme.of(context).primaryColorLight,
      avatar: widget.feature.enabled
          ? Icon(
              Icons.check,
              size: 12,
              color: Colors.green,
            )
          : Icon(
              Icons.add,
              size: 12,
              color: Theme.of(context).accentColor,
            ),
      label: Text(
        widget.feature.name,
        style: TextStyle(
          color: widget.feature.enabled ? Colors.green : Theme.of(context).accentColor,
        ),
      ),
      onPressed: () {
        setState(() {
          widget.feature.enabled = !widget.feature.enabled;
          print("Widget enabled = ${widget.feature.enabled}");
        });
      },
    );
  }
}
