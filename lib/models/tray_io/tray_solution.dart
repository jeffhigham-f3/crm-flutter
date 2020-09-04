import 'package:meta/meta.dart';

class TraySolution {
  final String id;
  final String title;
  final String description;
  bool enabled;

  TraySolution({
    @required this.id,
    @required this.title,
    @required this.description,
  }) {
    this.enabled = false;
  }

  factory TraySolution.fromTrayGraphQL(Map<String, Object> solution) {
    final Map<String, Object> node = solution['node'];
    final id = node['id'];
    final title = node['title'];
    final description = node['description'];
    return TraySolution(
      id: id,
      title: title,
      description: description,
    );
  }

  @override
  String toString() => 'id: $id, title: $title, description: $description';

  static final String readIndexSchema = r'''
query {
  viewer {
    solutions {
      edges {
        node {
          id
          title
          description
          tags
          customFields {
            key
            value
          }
          configSlots {
            externalId
            title
            defaultValue
          }
          
        }
        cursor
      }
      pageInfo {
          hasNextPage
          endCursor
          hasPreviousPage
          startCursor
      }
    }
  }
}
''';
}
