import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:poke_dex/features/pokemon/presentation/widgets/pokemon_card.dart';

void main() {
  group('PokemonCard', () {
    testWidgets('deve exibir o card corretamente', (WidgetTester tester) async {
      // Arrange
      const pokemon = PokemonEntity(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'https://example.com/bulbasaur.png',
        types: ['grass', 'poison'],
        height: 7,
        weight: 69,
        stats: [],
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PokemonCard(pokemon: pokemon)),
        ),
      );

      // Assert
      expect(find.byType(PokemonCard), findsOneWidget);
      expect(find.text('BULBASAUR'), findsOneWidget);
    });

    testWidgets('deve exibir o nome do pokémon em maiúsculas', (
      WidgetTester tester,
    ) async {
      // Arrange
      const pokemon = PokemonEntity(
        id: 4,
        name: 'charmander',
        imageUrl: 'https://example.com/charmander.png',
        types: ['fire'],
        height: 6,
        weight: 85,
        stats: [],
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PokemonCard(pokemon: pokemon)),
        ),
      );

      // Assert
      expect(find.text('CHARMANDER'), findsOneWidget);
    });

    testWidgets('deve exibir os tipos do pokémon', (WidgetTester tester) async {
      // Arrange
      const pokemon = PokemonEntity(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'https://example.com/bulbasaur.png',
        types: ['grass', 'poison'],
        height: 7,
        weight: 69,
        stats: [],
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PokemonCard(pokemon: pokemon)),
        ),
      );

      // Assert
      expect(find.byType(Chip), findsWidgets);
    });

    testWidgets('deve chamar onTap quando clicado', (
      WidgetTester tester,
    ) async {
      // Arrange
      const pokemon = PokemonEntity(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'https://example.com/bulbasaur.png',
        types: ['grass'],
        height: 7,
        weight: 69,
        stats: [],
      );
      var tapped = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonCard(
              pokemon: pokemon,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PokemonCard));
      await tester.pumpAndSettle();

      // Assert
      expect(tapped, true);
    });

    testWidgets('deve exibir um único tipo quando o pokémon tem um tipo', (
      WidgetTester tester,
    ) async {
      // Arrange
      const pokemon = PokemonEntity(
        id: 25,
        name: 'pikachu',
        imageUrl: 'https://example.com/pikachu.png',
        types: ['electric'],
        height: 4,
        weight: 60,
        stats: [],
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PokemonCard(pokemon: pokemon)),
        ),
      );

      // Assert
      expect(find.byType(Chip), findsOneWidget);
      expect(find.text('PIKACHU'), findsOneWidget);
    });

    testWidgets('deve renderizar sem erro quando onTap é null', (
      WidgetTester tester,
    ) async {
      // Arrange
      const pokemon = PokemonEntity(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'https://example.com/bulbasaur.png',
        types: ['grass'],
        height: 7,
        weight: 69,
        stats: [],
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: PokemonCard(pokemon: pokemon, onTap: null)),
        ),
      );

      // Assert
      expect(find.byType(PokemonCard), findsOneWidget);
      expect(find.text('BULBASAUR'), findsOneWidget);
    });
  });
}
