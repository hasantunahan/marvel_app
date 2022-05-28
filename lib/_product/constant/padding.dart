import 'package:flutter/cupertino.dart';

class AppPadding {
  AppPadding._init();
  static AppPadding? _instance;
  static AppPadding get instance {
    _instance ??= AppPadding._init();
    return _instance!;
  }

  double get mediumValue => 16.0;

  EdgeInsets get allPaddingMedium => EdgeInsets.all(mediumValue);
}
