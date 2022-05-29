import "package:flutter/material.dart";

enum TransactionType { FADE, SCALE }

class NavigationRouter {
  NavigationRouter._init();

  static Route<dynamic> onGenerateRoute(RouteSettings settings, Widget Function(RouteSettings settings) routeGenerator,
      {TransactionType? transactionType}) {
    final Widget page = routeGenerator(settings);

    return _goToPage(page, settings, transactionType: transactionType);
  }

  static PageRouteBuilder<Object> _goToPage(Widget page, RouteSettings settings, {TransactionType? transactionType}) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return page;
        },
        settings: settings,
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          switch (transactionType) {
            case TransactionType.FADE:
              return _defaultTransaction(animation, child);
            case TransactionType.SCALE:
              return scaleTransition(animation, child);
            default:
              return _defaultTransaction(animation, child);
          }
        });
  }

  static ScaleTransition scaleTransition(Animation<double> animation, Widget child) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ),
      ),
      child: child,
    );
  }

  static FadeTransition _defaultTransaction(Animation<double> animation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
