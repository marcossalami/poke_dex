import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:poke_dex/features/pokemon/domain/usecases/get_pokemons.dart';

import '../../../../mocks/mock_pokemon_repository.dart';

void main() {
  late GetPokemons usecase;
  late MockPokemonRepository repository;

  setUp(() {
    repository = MockPokemonRepository();
    usecase = GetPokemons(repository);
  });

  group('GetPokemons', () {
    test('deve retornar lista de pokémons quando bem-sucedido', () async {
      // Arrange
      const limit = 20;
      const offset = 0;
      final pokemons = [
        const PokemonEntity(
          id: 1,
          name: 'bulbasaur',
          imageUrl: 'url',
          types: ['grass', 'poison'],
          height: 7,
          weight: 69,
          stats: [],
        ),
        const PokemonEntity(
          id: 2,
          name: 'ivysaur',
          imageUrl: 'url',
          types: ['grass', 'poison'],
          height: 10,
          weight: 130,
          stats: [],
        ),
      ];

      when(
        () => repository.getPokemons(limit: limit, offset: offset),
      ).thenAnswer((_) async => pokemons);

      // Act
      final result = await usecase(limit: limit, offset: offset);

      // Assert
      expect(result, pokemons);
      expect(result.length, 2);
      expect(result[0].name, 'bulbasaur');
      verify(
        () => repository.getPokemons(limit: limit, offset: offset),
      ).called(1);
    });

    test('deve retornar lista vazia quando não há pokémons', () async {
      // Arrange
      const limit = 20;
      const offset = 0;

      when(
        () => repository.getPokemons(limit: limit, offset: offset),
      ).thenAnswer((_) async => []);

      // Act
      final result = await usecase(limit: limit, offset: offset);

      // Assert
      expect(result, isEmpty);
      verify(
        () => repository.getPokemons(limit: limit, offset: offset),
      ).called(1);
    });

    test('deve lançar exceção quando há erro no repositório', () async {
      // Arrange
      const limit = 20;
      const offset = 0;

      when(
        () => repository.getPokemons(limit: limit, offset: offset),
      ).thenThrow(Exception('Erro ao buscar pokémons'));

      // Act & Assert
      expect(() => usecase(limit: limit, offset: offset), throwsException);
    });

    test('deve chamar repositório com parâmetros corretos', () async {
      // Arrange
      const limit = 10;
      const offset = 5;

      when(
        () => repository.getPokemons(limit: limit, offset: offset),
      ).thenAnswer((_) async => []);

      // Act
      await usecase(limit: limit, offset: offset);

      // Assert
      verify(
        () => repository.getPokemons(limit: limit, offset: offset),
      ).called(1);
    });
  });
}
