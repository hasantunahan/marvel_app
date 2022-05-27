import 'package:marvel_api/_product/extension/assets_extension.dart';

class Assets {
  Assets._init();
  static Assets? _instance;
  static Assets get instance {
    _instance ??= Assets._init();
    return _instance!;
  }

  /// String to PNG
  String get logo => "logo".toPng;
}
