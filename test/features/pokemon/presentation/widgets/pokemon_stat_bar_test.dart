import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_stat_entity.dart';
import 'package:poke_dex/features/pokemon/presentation/widgets/pokemon_stat_bar.dart';

void main() {
  group('PokemonStatBar', () {
    testWidgets('deve exibir a barra de stat corretamente', (
      WidgetTester tester,
    ) async {
      // Arrange
      const stat = PokemonStatEntity(name: 'hp', value: 45);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonStatBar(stat: stat, color: Colors.red),
          ),
        ),
      );

      // Assert
      expect(find.byType(PokemonStatBar), findsOneWidget);
      expect(find.text('45'), findsOneWidget);
    });

    testWidgets('deve exibir o valor do stat', (WidgetTester tester) async {
      // Arrange
      const stat = PokemonStatEntity(name: 'attack', value: 49);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonStatBar(stat: stat, color: Colors.orange),
          ),
        ),
      );

      // Assert
      expect(find.text('49'), findsOneWidget);
    });

    testWidgets('deve exibir LinearProgressIndicator', (
      WidgetTester tester,
    ) async {
      // Arrange
      const stat = PokemonStatEntity(name: 'defense', value: 49);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonStatBar(stat: stat, color: Colors.blue),
          ),
        ),
      );

      // Assert
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('deve aceitar diferentes cores', (WidgetTester tester) async {
      // Arrange
      const stat = PokemonStatEntity(name: 'speed', value: 90);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonStatBar(stat: stat, color: Colors.yellow),
          ),
        ),
      );

      // Assert
      expect(find.byType(PokemonStatBar), findsOneWidget);
    });

    testWidgets('deve exibir stats com valores diferentes', (
      WidgetTester tester,
    ) async {
      // Arrange
      const stats = [
        PokemonStatEntity(name: 'hp', value: 35),
        PokemonStatEntity(name: 'attack', value: 55),
        PokemonStatEntity(name: 'defense', value: 40),
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: stats
                  .map((stat) => PokemonStatBar(stat: stat, color: Colors.blue))
                  .toList(),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('35'), findsOneWidget);
      expect(find.text('55'), findsOneWidget);
      expect(find.text('40'), findsOneWidget);
    });

    testWidgets('deve ter padding vertical correto', (
      WidgetTester tester,
    ) async {
      // Arrange
      const stat = PokemonStatEntity(name: 'hp', value: 45);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonStatBar(stat: stat, color: Colors.red),
          ),
        ),
      );

      // Assert
      expect(find.byType(Padding), findsWidgets);
    });
  });
}
