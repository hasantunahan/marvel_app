import "package:flutter/material.dart";

extension ScrollControllerExtension on ScrollController {
  bool get canLoadMore {
    return position.pixels >= position.maxScrollExtent - 50;
  }
}
