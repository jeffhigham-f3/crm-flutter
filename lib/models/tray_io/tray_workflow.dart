import 'package:meta/meta.dart';

class TrayWorkflow {
  final String uuid;
  final String title;
  final String description;
  final String slug;

  TrayWorkflow({
    @required this.uuid,
    @required this.title,
    @required this.description,
    @required this.slug,
  });

  @override
  String toString() =>
      'uuid: ${this.uuid},\ntitle: ${this.title},\description: ${this.description},\nslug: ${this.slug}';
}
