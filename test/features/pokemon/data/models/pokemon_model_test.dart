import 'package:flutter_test/flutter_test.dart';
import 'package:poke_dex/features/pokemon/data/models/pokemon_model.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_stat_entity.dart';

void main() {
  group('PokemonModel', () {
    group('constructor', () {
      test('deve criar uma instância de PokemonModel', () {
        // Arrange & Act
        const pokemon = PokemonModel(
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
        expect(pokemon, isA<PokemonModel>());
        expect(pokemon, isA<PokemonEntity>());
        expect(pokemon.id, 1);
        expect(pokemon.name, 'bulbasaur');
        expect(pokemon.types.length, 2);
        expect(pokemon.stats.length, 2);
      });

      test('deve herdar de PokemonEntity', () {
        // Arrange & Act
        const pokemon = PokemonModel(
          id: 1,
          name: 'bulbasaur',
          imageUrl: 'url',
          types: ['grass'],
          height: 7,
          weight: 69,
          stats: [],
        );

        // Assert
        expect(pokemon, isA<PokemonEntity>());
      });
    });

    group('fromJson', () {
      test('deve criar um PokemonModel a partir do JSON da API Pokémon', () {
        // Arrange
        final jsonData = {
          'id': 1,
          'name': 'bulbasaur',
          'sprites': {
            'other': {
              'official-artwork': {
                'front_default':
                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
              },
            },
          },
          'types': [
            {
              'type': {'name': 'grass'},
            },
            {
              'type': {'name': 'poison'},
            },
          ],
          'height': 7,
          'weight': 69,
          'stats': [
            {
              'stat': {'name': 'hp'},
              'base_stat': 45,
            },
            {
              'stat': {'name': 'attack'},
              'base_stat': 49,
            },
            {
              'stat': {'name': 'defense'},
              'base_stat': 49,
            },
            {
              'stat': {'name': 'sp. atk'},
              'base_stat': 65,
            },
            {
              'stat': {'name': 'sp. def'},
              'base_stat': 65,
            },
            {
              'stat': {'name': 'speed'},
              'base_stat': 45,
            },
          ],
        };

        // Act
        final pokemon = PokemonModel.fromJson(jsonData);

        // Assert
        expect(pokemon, isA<PokemonModel>());
        expect(pokemon.id, 1);
        expect(pokemon.name, 'bulbasaur');
        expect(pokemon.types.length, 2);
        expect(pokemon.types[0], 'grass');
        expect(pokemon.types[1], 'poison');
        expect(pokemon.height, 7);
        expect(pokemon.weight, 69);
        expect(pokemon.stats.length, 6);
        expect(pokemon.stats[0].name, 'hp');
        expect(pokemon.stats[0].value, 45);
      });

      test('deve retornar imageUrl vazia quando front_default é null', () {
        // Arrange
        final jsonData = {
          'id': 1,
          'name': 'test',
          'sprites': {
            'other': {
              'official-artwork': {'front_default': null},
            },
          },
          'types': [],
          'height': 0,
          'weight': 0,
          'stats': [],
        };

        // Act
        final pokemon = PokemonModel.fromJson(jsonData);

        // Assert
        expect(pokemon.imageUrl, '');
      });

      test('deve mapear todos os tipos corretamente', () {
        // Arrange
        final jsonData = {
          'id': 25,
          'name': 'pikachu',
          'sprites': {
            'other': {
              'official-artwork': {'front_default': 'url'},
            },
          },
          'types': [
            {
              'type': {'name': 'electric'},
            },
          ],
          'height': 4,
          'weight': 60,
          'stats': [],
        };

        // Act
        final pokemon = PokemonModel.fromJson(jsonData);

        // Assert
        expect(pokemon.types, ['electric']);
      });

      test('deve mapear todos os stats corretamente', () {
        // Arrange
        final jsonData = {
          'id': 25,
          'name': 'pikachu',
          'sprites': {
            'other': {
              'official-artwork': {'front_default': 'url'},
            },
          },
          'types': [],
          'height': 4,
          'weight': 60,
          'stats': [
            {
              'stat': {'name': 'hp'},
              'base_stat': 35,
            },
            {
              'stat': {'name': 'attack'},
              'base_stat': 55,
            },
            {
              'stat': {'name': 'defense'},
              'base_stat': 40,
            },
          ],
        };

        // Act
        final pokemon = PokemonModel.fromJson(jsonData);

        // Assert
        expect(pokemon.stats.length, 3);
        expect(pokemon.stats[0].name, 'hp');
        expect(pokemon.stats[0].value, 35);
        expect(pokemon.stats[1].name, 'attack');
        expect(pokemon.stats[1].value, 55);
        expect(pokemon.stats[2].name, 'defense');
        expect(pokemon.stats[2].value, 40);
      });
    });

    group('Equatable', () {
      test('dois PokemonModels com os mesmos dados devem ser iguais', () {
        // Arrange
        const pokemon1 = PokemonModel(
          id: 1,
          name: 'bulbasaur',
          imageUrl: 'url',
          types: ['grass', 'poison'],
          height: 7,
          weight: 69,
          stats: [],
        );
        const pokemon2 = PokemonModel(
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

      test('dois PokemonModels com dados diferentes não devem ser iguais', () {
        // Arrange
        const pokemon1 = PokemonModel(
          id: 1,
          name: 'bulbasaur',
          imageUrl: 'url',
          types: ['grass', 'poison'],
          height: 7,
          weight: 69,
          stats: [],
        );
        const pokemon2 = PokemonModel(
          id: 2,
          name: 'ivysaur',
          imageUrl: 'url',
          types: ['grass', 'poison'],
          height: 10,
          weight: 130,
          stats: [],
        );

        // Act & Assert
        expect(pokemon1, isNot(pokemon2));
      });
    });
  });
}
