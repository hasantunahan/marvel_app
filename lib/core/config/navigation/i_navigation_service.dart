import 'package:marvel_api/core/config/navigation/arguments.dart';

abstract class INavigationService {
  Future<Object?> navigateTo({required String path, NavigationArguments? args});
  Future<Object?> navigateToReset({required String path, NavigationArguments? args});
  void back({NavigationArguments? args});
}
