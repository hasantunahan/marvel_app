import 'package:flutter/material.dart';
import 'package:marvel_api/core/extension/context_extension.dart';

class MarvelBaseWidget extends StatelessWidget {
  final Widget child;
  final bool hideAppBar;
  final String title;
  const MarvelBaseWidget({
    Key? key,
    required this.child,
    this.hideAppBar = false,
    this.title = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !hideAppBar ? _renderAppBar(context) : null,
      body: child,
    );
  }

  AppBar _renderAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.colorScheme.background,
      elevation: 0,
      centerTitle: false,
      title: Text(
        title,
        style: TextStyle(color: context.theme.colorScheme.primary, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
