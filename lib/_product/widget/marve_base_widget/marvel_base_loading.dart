import 'package:flutter/material.dart';

class MarvelBaseLoading extends StatelessWidget {
  final Widget? child;
  const MarvelBaseLoading({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      child: Center(
        child: child,
      ),
    );
  }
}
