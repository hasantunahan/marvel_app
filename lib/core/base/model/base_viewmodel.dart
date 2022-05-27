import "package:flutter/material.dart";
abstract class BaseViewModel {
  BuildContext? mContext;

  void setContext(BuildContext context);
  void init();
  void dispose() {}
  void didPopNext() {}
}
