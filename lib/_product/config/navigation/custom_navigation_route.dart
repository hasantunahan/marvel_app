import 'package:flutter/material.dart';
import 'package:marvel_api/_product/constant/routes_path.dart';
import 'package:marvel_api/_product/widget/not_found_view/not_found_view.dart';
import 'package:marvel_api/view/home/view/home_view.dart';
import 'package:marvel_api/view/splash/view/splash_view.dart';

class CustomNavigationRouter {
  CustomNavigationRouter._();
  static CustomNavigationRouter? _instance;
  static CustomNavigationRouter get instance {
    _instance ??= CustomNavigationRouter._();
    return _instance!;
  }

  final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

  Widget routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case RoutesPath.splash:
        return SplashView();
      case RoutesPath.home:
        return HomeView();
      default:
        return const NotFoundView();
    }
  }
}
