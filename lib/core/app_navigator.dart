import 'package:flutter/material.dart';

abstract class AppNavigator {
  Future<dynamic>? pushNamed(String routeName, {dynamic arguments});

  Future<dynamic>? pushReplacementNamed(String routeName, {dynamic arguments});

  Future<dynamic>? pushNamedAndRemoveUntil(
    String routeName, {
    dynamic arguments,
  });

  Future<dynamic>? popAndPushNamed(String routeName, {dynamic arguments});

  void pop<T extends Object?>([T? result]);
}

class AppNavigatorImpl extends AppNavigator {
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<dynamic>? pushNamed(String routeName, {arguments}) =>
      navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);

  @override
  Future? pushReplacementNamed(String routeName, {arguments}) => navigatorKey
      .currentState
      ?.pushReplacementNamed(routeName, arguments: arguments);

  @override
  void pop<T extends Object?>([T? result]) =>
      navigatorKey.currentState!.pop(result);

  @override
  Future? pushNamedAndRemoveUntil(String routeName, {arguments}) =>
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        routeName,
        (Route<dynamic> route) => false,
        arguments: arguments,
      );

  @override
  Future? popAndPushNamed(String routeName, {arguments}) => navigatorKey
      .currentState
      ?.popAndPushNamed(routeName, arguments: arguments);
}
