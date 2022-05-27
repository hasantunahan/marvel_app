import "package:flutter/material.dart";
import 'package:marvel_api/core/config/navigation/arguments.dart';
import 'package:marvel_api/core/config/navigation/i_navigation_service.dart';

class NavigationService implements INavigationService {
  NavigationService._init();
  static NavigationService? _instance;
  static NavigationService get i => instance;
  static NavigationService get instance {
    _instance ??= NavigationService._init();
    return _instance!;
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void back({Object? args}) {
    navigatorKey.currentState?.pop(args);
  }

  @override
  Future<Object?> navigateTo({
    required String path,
    NavigationArguments? args,
  }) async {
    return await navigatorKey.currentState?.pushNamed(
      path,
      arguments: args,
    );
  }

  bool removeAllOldRoutes(Route<dynamic> route) => false;
  @override
  Future<Object?> navigateToReset({
    required String path,
    NavigationArguments? args,
  }) async {
    return await navigatorKey.currentState?.pushNamedAndRemoveUntil(
      path,
      removeAllOldRoutes,
      arguments: args,
    );
  }
}
