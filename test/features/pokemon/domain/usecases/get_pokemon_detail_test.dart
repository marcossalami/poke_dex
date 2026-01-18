import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_stat_entity.dart';
import 'package:poke_dex/features/pokemon/domain/usecases/get_pokemon_detail.dart';

import '../../../../mocks/mock_pokemon_repository.dart';

void main() {
  late GetPokemonDetail usecase;
  late MockPokemonRepository repository;

  setUp(() {
    repository = MockPokemonRepository();
    usecase = GetPokemonDetail(repository);
  });

  group('GetPokemonDetail', () {
    test('deve retornar detalhes do pokémon quando bem-sucedido', () async {
      // Arrange
      const name = 'bulbasaur';
      const pokemon = PokemonEntity(
        id: 1,
        name: 'bulbasaur',
        imageUrl: 'url',
        types: ['grass', 'poison'],
        height: 7,
        weight: 69,
        stats: [
          PokemonStatEntity(name: 'hp', value: 45),
          PokemonStatEntity(name: 'attack', value: 49),
        ],
      );

      when(
        () => repository.getPokemonDetail(name),
      ).thenAnswer((_) async => pokemon);

      // Act
      final result = await usecase(GetPokemonDetailParams(name: name));

      // Assert
      expect(result, pokemon);
      expect(result.name, name);
      expect(result.stats.length, 2);
      verify(() => repository.getPokemonDetail(name)).called(1);
    });

    test('deve lançar exceção quando há erro no repositório', () async {
      // Arrange
      const name = 'pokemon_inexistente';

      when(
        () => repository.getPokemonDetail(name),
      ).thenThrow(Exception('Pokémon não encontrado'));

      // Act & Assert
      expect(
        () => usecase(GetPokemonDetailParams(name: name)),
        throwsException,
      );
    });
  });
}
