import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/models/crm/import.dart';

class CrmFeatureWidget extends StatelessWidget {
  final CrmFeature feature;
  CrmFeatureWidget({Key key, this.feature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      labelStyle: TextStyle(color: Theme.of(context).primaryColor),
      selectedColor: Theme.of(context).buttonColor,
      checkmarkColor: Theme.of(context).primaryColor,
      label: Text(feature.name),
      selected: false,
      onSelected: (bool value) => print('selected'),
    );
  }
}
