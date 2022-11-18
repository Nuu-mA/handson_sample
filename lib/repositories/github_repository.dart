import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:template_flutter/graphql/mutation.dart';
import 'package:template_flutter/graphql/query.dart';
import 'package:template_flutter/model/issue.dart';
import 'package:template_flutter/plugins/graphql_client.dart';

Future<List<Issue>?> fetchIssues() async {
  var response = await client.query(
    QueryOptions(
      document: gql(issuesQuery),
    ),
  );

  final List<dynamic>? results =
      response.data?['repository']?['issues']?['nodes'];
  final List<Issue> issueList =
      results!.map((dynamic item) => Issue.fromJson(item)).toList();
  return issueList;
}

Future<void> createIssue({required String title, required String body}) async {
  final MutationOptions options = MutationOptions(
    document: gql(createMutation),
    variables: <String, dynamic>{
      'titleText': title,
      'bodyText': body,
    },
  );

  final QueryResult result = await client.mutate(options);
  if (result.hasException) {
    log(result.exception.toString());
    return;
  }
}

Future<void> updateIssue(
    {required String id, required String title, required String body}) async {
  final MutationOptions options = MutationOptions(
    document: gql(updateMutation),
    variables: <String, dynamic>{
      'idText': id,
      'titleText': title,
      'bodyText': body,
    },
  );

  final QueryResult result = await client.mutate(options);
  if (result.hasException) {
    log(result.exception.toString());
    return;
  }
}
