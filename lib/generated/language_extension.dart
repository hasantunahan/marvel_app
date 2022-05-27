import 'package:flutter/cupertino.dart';
import 'package:marvel_api/generated/l10n.dart';

extension LanguageExtension on BuildContext {
  S get lang => S.of(this);
}
