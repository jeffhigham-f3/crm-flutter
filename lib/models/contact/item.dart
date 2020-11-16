import 'package:quiver/core.dart';

class Item {
  Item({this.label, this.value});

  String label, value;

  Item.fromMap(Map m) {
    label = m["label"];
    value = m["value"];
  }

  @override
  bool operator ==(Object other) {
    return other is Item && this.label == other.label && this.value == other.value;
  }

  @override
  int get hashCode => hash2(label ?? "", value ?? "");

  static Map _toMap(Item i) => {"label": i.label, "value": i.value};
}
