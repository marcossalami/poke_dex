import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_dex/features/pokemon/presentation/widgets/info_column.dart';

void main() {
  group('InfoColumn', () {
    testWidgets('deve exibir label e value corretamente', (
      WidgetTester tester,
    ) async {
      const label = 'Altura';
      const value = '7 dm';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InfoColumn(label: label, value: value),
          ),
        ),
      );

      expect(find.text(value), findsOneWidget);
      expect(find.text(label), findsOneWidget);
    });

    testWidgets('deve exibir value em texto maior', (
      WidgetTester tester,
    ) async {
      const label = 'Peso';
      const value = '69 kg';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InfoColumn(label: label, value: value),
          ),
        ),
      );

      expect(find.text(value), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
    });

    testWidgets('deve exibir label em cinza', (WidgetTester tester) async {
      const label = 'Tipo';
      const value = 'Grass';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InfoColumn(label: label, value: value),
          ),
        ),
      );

      expect(find.text(label), findsOneWidget);
      expect(find.text(value), findsOneWidget);
    });

    testWidgets('deve exibir múltiplas InfoColumns em linha', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                InfoColumn(label: 'Altura', value: '7 dm'),
                InfoColumn(label: 'Peso', value: '69 kg'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(InfoColumn), findsNWidgets(2));
      expect(find.text('Altura'), findsOneWidget);
      expect(find.text('Peso'), findsOneWidget);
    });
  });
}
