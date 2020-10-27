import 'package:meta/meta.dart';

class TrayWorkflow {
  final String id;
  final String title;
  final String description;
  final String slug;

  TrayWorkflow({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.slug,
  });

  @override
  String toString() =>
      '\nTrayWorkflow\nid: ${this.id},\ntitle: ${this.title},\ndescription: ${this.description},\nslug: ${this.slug}';
}
