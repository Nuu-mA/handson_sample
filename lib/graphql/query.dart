String issuesQuery = """
  query {
    repository(name: "handson_sample", owner: "Nuu-mA") {
      description
      createdAt
      name
      issues(
        states: OPEN
        first: 100
        orderBy: { field: CREATED_AT, direction: DESC }
      ) {
        nodes {
          id
          body
          updatedAt
          title
          url
        }
      }
    }
  }
""";
