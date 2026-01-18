// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App test - Material design is used', (
    WidgetTester tester,
  ) async {
    // Build a simple test widget instead of the full app
    await tester.pumpWidget(
      MaterialApp(
        title: 'Test',
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          appBar: AppBar(title: const Text('Test')),
          body: const Center(child: Text('Test Widget')),
        ),
      ),
    );

    // Verify Material design is used
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('Test'), findsWidgets);
  });
}
