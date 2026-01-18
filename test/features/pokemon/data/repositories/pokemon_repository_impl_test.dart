import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_dex/features/pokemon/data/models/pokemon_model.dart';
import 'package:poke_dex/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_entity.dart';

import '../../../../mocks/mock_pokemon_datasource.dart';

void main() {
  late MockPokemonRemoteDataSource datasource;
  late PokemonRepositoryImpl repository;

  setUp(() {
    datasource = MockPokemonRemoteDataSource();
    repository = PokemonRepositoryImpl(datasource);
  });

  group('PokemonRepositoryImpl', () {
    group('getPokemons', () {
      test('deve retornar lista de pokémons quando bem-sucedido', () async {
        // Arrange
        const limit = 20;
        const offset = 0;
        final pokemons = [
          const PokemonModel(
            id: 1,
            name: 'bulbasaur',
            imageUrl: '',
            types: ['grass', 'poison'],
            height: 7,
            weight: 69,
            stats: [],
          ),
          const PokemonModel(
            id: 2,
            name: 'ivysaur',
            imageUrl: '',
            types: ['grass', 'poison'],
            height: 10,
            weight: 130,
            stats: [],
          ),
        ];

        when(
          () => datasource.getPokemons(limit: limit, offset: offset),
        ).thenAnswer((_) async => pokemons);

        // Act
        final result = await repository.getPokemons(
          limit: limit,
          offset: offset,
        );

        // Assert
        expect(result, isA<List<PokemonEntity>>());
        expect(result.length, 2);
        expect(result[0].name, 'bulbasaur');
        expect(result[1].name, 'ivysaur');
        verify(
          () => datasource.getPokemons(limit: limit, offset: offset),
        ).called(1);
      });

      test('deve retornar lista vazia quando não há pokémons', () async {
        // Arrange
        const limit = 20;
        const offset = 0;

        when(
          () => datasource.getPokemons(limit: limit, offset: offset),
        ).thenAnswer((_) async => []);

        // Act
        final result = await repository.getPokemons(
          limit: limit,
          offset: offset,
        );

        // Assert
        expect(result, isEmpty);
        verify(
          () => datasource.getPokemons(limit: limit, offset: offset),
        ).called(1);
      });

      test('deve lançar exceção quando há erro na datasource', () async {
        // Arrange
        const limit = 20;
        const offset = 0;

        when(
          () => datasource.getPokemons(limit: limit, offset: offset),
        ).thenThrow(Exception('Erro ao buscar pokémons'));

        // Act & Assert
        expect(
          () => repository.getPokemons(limit: limit, offset: offset),
          throwsException,
        );
      });
    });

    group('getPokemonDetail', () {
      test('deve retornar detalhes do pokémon quando bem-sucedido', () async {
        // Arrange
        const name = 'bulbasaur';
        const pokemon = PokemonModel(
          id: 1,
          name: 'bulbasaur',
          imageUrl: 'url',
          types: ['grass', 'poison'],
          height: 7,
          weight: 69,
          stats: [],
        );

        when(
          () => datasource.getPokemonDetail(name),
        ).thenAnswer((_) async => pokemon);

        // Act
        final result = await repository.getPokemonDetail(name);

        // Assert
        expect(result, isA<PokemonEntity>());
        expect(result.name, name);
        expect(result.types, ['grass', 'poison']);
        verify(() => datasource.getPokemonDetail(name)).called(1);
      });

      test('deve lançar exceção quando o pokémon não é encontrado', () async {
        // Arrange
        const name = 'pokemon_inexistente';

        when(
          () => datasource.getPokemonDetail(name),
        ).thenThrow(Exception('Pokémon não encontrado'));

        // Act & Assert
        expect(() => repository.getPokemonDetail(name), throwsException);
      });
    });
  });
}
