import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import 'package:marvel_api/core/widgets/delayed_widget/delayed_widget.dart';

const duration = Duration(milliseconds: 500);
const text = "testText";

void main() {
  group("Delayed Display", () {
    testWidgets("Delayed", (tester) async {
      const widget = MaterialApp(
        home: DelayedDisplay(
          delay: duration,
          child: Text(text),
        ),
      );

      await tester.pumpWidget(widget);

      await tester.pump();

      final display = find.byType(DelayedDisplay);
      expect(display, findsOneWidget);

      expect(find.text(text), findsOneWidget);
    });
  });
}
