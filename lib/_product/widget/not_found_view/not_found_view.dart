import 'package:flutter/material.dart';
import 'package:marvel_api/generated/language_extension.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(context.lang.view_page_not_found),
    );
  }
}
