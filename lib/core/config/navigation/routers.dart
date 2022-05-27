import "package:flutter/material.dart";

class NavigationRouter {
  NavigationRouter._init();

  static Route<dynamic> onGenerateRoute(
    RouteSettings settings,
    Widget Function(RouteSettings settings) routeGenerator,
  ) {
    final Widget page = routeGenerator(settings);

    return goToPage(page, settings);
  }

  static MaterialPageRoute<Object> goToPage(Widget page, RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => page,
      settings: settings,
    );
  }
}
