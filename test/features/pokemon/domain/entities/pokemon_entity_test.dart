import 'package:flutter_test/flutter_test.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_stat_entity.dart';

void main() {
  group('PokemonEntity', () {
    test('deve criar uma instância válida de PokemonEntity', () {
      // Arrange & Act
      const pokemon = PokemonEntity(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'https://example.com/bulbasaur.png',
        types: ['grass', 'poison'],
        height: 7,
        weight: 69,
        stats: [
          PokemonStatEntity(name: 'hp', value: 45),
          PokemonStatEntity(name: 'attack', value: 49),
        ],
      );

      // Assert
      expect(pokemon.id, 1);
      expect(pokemon.name, 'bulbasaur');
      expect(pokemon.imageUrl, 'https://example.com/bulbasaur.png');
      expect(pokemon.types, ['grass', 'poison']);
      expect(pokemon.height, 7);
      expect(pokemon.weight, 69);
      expect(pokemon.stats.length, 2);
    });

    test('deve manter a imutabilidade com const', () {
      // Arrange
      const pokemon1 = PokemonEntity(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'url',
        types: ['grass'],
        height: 7,
        weight: 69,
        stats: [],
      );
      const pokemon2 = PokemonEntity(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'url',
        types: ['grass'],
        height: 7,
        weight: 69,
        stats: [],
      );

      // Act & Assert
      expect(identical(pokemon1, pokemon2), true);
    });

    test('dois pokémons com os mesmos dados devem ser iguais', () {
      // Arrange
      const pokemon1 = PokemonEntity(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'url',
        types: ['grass', 'poison'],
        height: 7,
        weight: 69,
        stats: [],
      );
      const pokemon2 = PokemonEntity(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'url',
        types: ['grass', 'poison'],
        height: 7,
        weight: 69,
        stats: [],
      );

      // Act & Assert
      expect(pokemon1, pokemon2);
    });

    test('dois pokémons com dados diferentes não devem ser iguais', () {
      // Arrange
      const pokemon1 = PokemonEntity(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'url',
        types: ['grass'],
        height: 7,
        weight: 69,
        stats: [],
      );
      const pokemon2 = PokemonEntity(
        id: 2,
        name: 'ivysaur',
        imageUrl: 'url',
        types: ['grass'],
        height: 10,
        weight: 130,
        stats: [],
      );

      // Act & Assert
      expect(pokemon1 == pokemon2, false);
    });

    test('deve aceitar lista vazia de types', () {
      // Arrange & Act
      const pokemon = PokemonEntity(
        id: 1,
        name: 'test',
        imageUrl: 'url',
        types: [],
        height: 0,
        weight: 0,
        stats: [],
      );

      // Assert
      expect(pokemon.types, isEmpty);
    });

    test('deve aceitar lista vazia de stats', () {
      // Arrange & Act
      const pokemon = PokemonEntity(
        id: 1,
        name: 'test',
        imageUrl: 'url',
        types: ['normal'],
        height: 0,
        weight: 0,
        stats: [],
      );

      // Assert
      expect(pokemon.stats, isEmpty);
    });

    test('deve aceitar múltiplos tipos', () {
      // Arrange
      const pokemon = PokemonEntity(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'url',
        types: ['grass', 'poison'],
        height: 7,
        weight: 69,
        stats: [],
      );

      // Act & Assert
      expect(pokemon.types.length, 2);
      expect(pokemon.types.contains('grass'), true);
      expect(pokemon.types.contains('poison'), true);
    });

    test('deve aceitar múltiplos stats', () {
      // Arrange
      const pokemon = PokemonEntity(
        id: 1,
        name: 'pikachu',
        imageUrl: 'url',
        types: ['electric'],
        height: 4,
        weight: 60,
        stats: [
          PokemonStatEntity(name: 'hp', value: 35),
          PokemonStatEntity(name: 'attack', value: 55),
          PokemonStatEntity(name: 'defense', value: 40),
          PokemonStatEntity(name: 'sp. atk', value: 50),
          PokemonStatEntity(name: 'sp. def', value: 50),
          PokemonStatEntity(name: 'speed', value: 90),
        ],
      );

      // Act & Assert
      expect(pokemon.stats.length, 6);
      expect(pokemon.stats[0].name, 'hp');
      expect(pokemon.stats[5].name, 'speed');
    });
  });

  group('PokemonStatEntity', () {
    test('deve criar uma instância válida de PokemonStatEntity', () {
      // Arrange & Act
      const stat = PokemonStatEntity(name: 'hp', value: 45);

      // Assert
      expect(stat.name, 'hp');
      expect(stat.value, 45);
    });

    test('dois stats com os mesmos dados devem ser iguais', () {
      // Arrange
      const stat1 = PokemonStatEntity(name: 'hp', value: 45);
      const stat2 = PokemonStatEntity(name: 'hp', value: 45);

      // Act & Assert
      expect(stat1, stat2);
    });

    test('dois stats com dados diferentes não devem ser iguais', () {
      // Arrange
      const stat1 = PokemonStatEntity(name: 'hp', value: 45);
      const stat2 = PokemonStatEntity(name: 'attack', value: 49);

      // Act & Assert
      expect(stat1 == stat2, false);
    });

    test('deve aceitar valores de stat diferentes', () {
      // Arrange & Act
      final stats = [
        const PokemonStatEntity(name: 'hp', value: 35),
        const PokemonStatEntity(name: 'attack', value: 55),
        const PokemonStatEntity(name: 'defense', value: 40),
      ];

      // Assert
      expect(stats[0].value, 35);
      expect(stats[1].value, 55);
      expect(stats[2].value, 40);
    });
  });
}
