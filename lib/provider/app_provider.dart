import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:template_flutter/plugins/graphql_client.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final clientValue = ValueNotifier<GraphQLClient>(
      client,
    );

    return GraphQLProvider(
      client: clientValue,
      child: child,
    );
  }
}
