import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/crm/import.dart';

class CrmFeatureWidget extends StatefulWidget {
  final CrmFeature feature;

  CrmFeatureWidget({Key key, this.feature}) : super(key: key);

  @override
  _CrmFeatureWidgetState createState() => _CrmFeatureWidgetState();
}

class _CrmFeatureWidgetState extends State<CrmFeatureWidget> {
  List<String> _filters = <String>[];

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      backgroundColor: Theme.of(context).buttonColor,
      labelStyle: TextStyle(color: Theme.of(context).primaryColor),
      selectedColor: Theme.of(context).buttonColor,
      checkmarkColor: Theme.of(context).primaryColor,
      label: Text(widget.feature.name),
      selected: _filters.contains(widget.feature.name) && false, // disable for now.
      onSelected: (bool value) {
        setState(() {
          if (value) {
            _filters.add(widget.feature.name);
          } else {
            _filters.removeWhere((String name) {
              return name == widget.feature.name;
            });
          }
        });
      },
    );
  }
}
