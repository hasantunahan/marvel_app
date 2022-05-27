import "package:flutter/material.dart";

typedef BottomSheetWidgetBuilder = Widget Function(BuildContext context);

class DefaultBottomSheet {
  final BuildContext context;
  final BottomSheetWidgetBuilder builder;
  final Color? backgroundColor;
  final double borderRadius;
  final bool clickDismiss;
  final bool draggable;
  final bool isScrollControlled;

  DefaultBottomSheet({
    required this.context,
    required this.builder,
    this.backgroundColor,
    this.borderRadius = 16.0,
    this.clickDismiss = true,
    this.draggable = true,
    this.isScrollControlled = false,
  });

  Future<T?> showBottom<T>() async {
    return await showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      builder: builder,
      isDismissible: clickDismiss,
      enableDrag: draggable,
    );
  }
}
