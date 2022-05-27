import 'package:flutter/material.dart';

enum AnimationPosition { TOP, LEFT, RIGHT, BOTTOM }

extension AnimationPositionExtension on AnimationPosition {
  Offset animate() {
    switch (this) {
      case AnimationPosition.TOP:
        return const Offset(0, -1);
      case AnimationPosition.BOTTOM:
        return const Offset(0, 1);
      case AnimationPosition.RIGHT:
        return const Offset(-1, 0);
      case AnimationPosition.LEFT:
        return const Offset(1, 0);
      default:
        return const Offset(0, 1);
    }
  }
}
