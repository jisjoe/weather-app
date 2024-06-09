import 'package:flutter/material.dart';
import 'package:weather_app/scope/global_bloc_scope.dart';
import 'package:weather_app/scope/global_provider_scope.dart';

class GlobalAppScope extends StatelessWidget {
  final Widget child;

  const GlobalAppScope({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalProviderScope(
      child: GlobalBlocScope(
        child: child,
      ),
    );
  }
}
