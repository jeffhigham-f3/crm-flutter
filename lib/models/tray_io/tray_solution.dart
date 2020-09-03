class TraySolution {
  String id;
  String title;
  String description;
  List<dynamic> tags;
  List<dynamic> customFields;
  List<dynamic> configSlots;

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
