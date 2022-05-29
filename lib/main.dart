import 'package:flutter/material.dart';
import 'package:marvel_api/_product/config/navigation/custom_navigation_route.dart';
import 'package:marvel_api/_product/config/theme/theme_change_provider.dart';
import 'package:marvel_api/core/config/navigation/navigation_service.dart';
import 'package:marvel_api/core/config/navigation/routers.dart';
import 'package:marvel_api/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Marvel App",
      debugShowCheckedModeBanner: false,
      locale: const Locale("en"),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: MarvelTheme.lightTheme,
      onGenerateRoute: (settings) =>
          NavigationRouter.onGenerateRoute(settings, CustomNavigationRouter.instance.routeGenerator),
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}
