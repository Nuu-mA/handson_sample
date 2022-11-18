const String createMutation = '''
  mutation (\$titleText: String!, \$bodyText: String!) {
    createIssue(input: {
      repositoryId: "R_kgDOIbROgw",
      title: \$titleText,
      body: \$bodyText
    }) {
      issue {
        id
      }
    }
  }
''';
const String updateMutation = '''
  mutation (\$idText: ID!, \$titleText: String!, \$bodyText: String!) {
    updateIssue(input: {
      id: \$idText,
      title: \$titleText,
      body: \$bodyText
    }) {
      issue {
        id
      }
    }
  }
''';
