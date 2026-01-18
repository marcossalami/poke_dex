import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_stat_entity.dart';
import 'package:poke_dex/features/pokemon/domain/usecases/get_pokemon_detail.dart';
import 'package:poke_dex/features/pokemon/domain/usecases/get_pokemons.dart';
import 'package:poke_dex/features/pokemon/presentation/state/pokemon_provider.dart';

class MockGetPokemons extends Mock implements GetPokemons {}

class MockGetPokemonDetail extends Mock implements GetPokemonDetail {}

void main() {
  late MockGetPokemons mockGetPokemons;
  late MockGetPokemonDetail mockGetPokemonDetail;
  late PokemonProvider provider;

  setUpAll(() {
    registerFallbackValue(GetPokemonDetailParams(name: ''));
  });

  setUp(() {
    mockGetPokemons = MockGetPokemons();
    mockGetPokemonDetail = MockGetPokemonDetail();
    provider = PokemonProvider(mockGetPokemons, mockGetPokemonDetail);
  });

  group('PokemonProvider', () {
    group('fetchPokemons', () {
      test('deve carregar lista de pokémons e notificar listeners', () async {
        // Arrange
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
          () => mockGetPokemons(limit: 20, offset: 0),
        ).thenAnswer((_) async => pokemons);

        final notifierCalls = <int>[];
        provider.addListener(() {
          notifierCalls.add(1);
        });

        // Act
        await provider.fetchPokemons();

        // Assert
        expect(provider.pokemons.length, 2);
        expect(provider.pokemons[0].name, 'bulbasaur');
        expect(provider.isLoading, false);
        expect(provider.hasError, false);
        expect(notifierCalls.length, 2); // Uma no início, uma no final
      });

      test('deve definir hasError como true quando ocorre erro', () async {
        // Arrange
        when(
          () => mockGetPokemons(limit: 20, offset: 0),
        ).thenThrow(Exception('Erro na API'));

        final notifierCalls = <int>[];
        provider.addListener(() {
          notifierCalls.add(1);
        });

        // Act
        await provider.fetchPokemons();

        // Assert
        expect(provider.hasError, true);
        expect(provider.isLoading, false);
        expect(provider.pokemons, isEmpty);
      });

      test('deve parar de carregar quando isLoading é true', () async {
        // Arrange
        provider.isLoading = true;

        // Act
        await provider.fetchPokemons();

        // Assert
        verifyNever(() => mockGetPokemons(limit: 20, offset: 0));
      });

      test('deve parar de carregar quando _hasReachedEnd é true', () async {
        // Arrange
        // Primeiro carregamento retorna lista vazia para ativar hasReachedEnd
        when(
          () => mockGetPokemons(limit: 20, offset: 0),
        ).thenAnswer((_) async => []);

        // Act - primeiro carregamento
        await provider.fetchPokemons();

        // Reset do mock para o segundo carregamento
        reset(mockGetPokemons);

        // Act - segundo carregamento
        await provider.fetchPokemons();

        // Assert - mock não foi chamado na segunda vez
        verifyNever(() => mockGetPokemons(limit: 20, offset: 20));
      });

      test('deve carregar a próxima página com offset correto', () async {
        // Arrange
        final pokemons = [
          const PokemonEntity(
            id: 1,
            name: 'bulbasaur',
            imageUrl: 'url',
            types: ['grass'],
            height: 7,
            weight: 69,
            stats: [],
          ),
        ];

        when(
          () => mockGetPokemons(limit: 20, offset: 0),
        ).thenAnswer((_) async => pokemons);

        when(
          () => mockGetPokemons(limit: 20, offset: 20),
        ).thenAnswer((_) async => pokemons);

        // Act
        await provider.fetchPokemons();
        await provider.fetchPokemons();

        // Assert
        verify(() => mockGetPokemons(limit: 20, offset: 0)).called(1);
        verify(() => mockGetPokemons(limit: 20, offset: 20)).called(1);
      });
    });

    group('fetchPokemonDetail', () {
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
          stats: [PokemonStatEntity(name: 'hp', value: 45)],
        );

        when(
          () => mockGetPokemonDetail(any()),
        ).thenAnswer((_) async => pokemon);

        // Act
        final result = await provider.fetchPokemonDetail(name);

        // Assert
        expect(result, pokemon);
        expect(result?.name, name);
      });

      test('deve retornar resultado em cache na segunda chamada', () async {
        // Arrange
        const name = 'bulbasaur';
        const pokemon = PokemonEntity(
          id: 1,
          name: 'bulbasaur',
          imageUrl: 'url',
          types: ['grass', 'poison'],
          height: 7,
          weight: 69,
          stats: [],
        );

        when(
          () => mockGetPokemonDetail(any()),
        ).thenAnswer((_) async => pokemon);

        // Act
        final result1 = await provider.fetchPokemonDetail(name);
        final result2 = await provider.fetchPokemonDetail(name);

        // Assert
        expect(result1, pokemon);
        expect(result2, pokemon);
        verify(
          () => mockGetPokemonDetail(any()),
        ).called(1); // Deve ser chamado apenas uma vez
      });
      test('deve retornar null quando ocorre erro', () async {
        // Arrange
        const name = 'pokemon_inexistente';

        when(
          () => mockGetPokemonDetail(any()),
        ).thenThrow(Exception('Pokémon não encontrado'));

        // Act
        final result = await provider.fetchPokemonDetail(name);

        // Assert
        expect(result, isNull);
      });

      test('deve fazer chamada ao usecase com parâmetros corretos', () async {
        // Arrange
        const name = 'charmander';
        const pokemon = PokemonEntity(
          id: 4,
          name: 'charmander',
          imageUrl: 'url',
          types: ['fire'],
          height: 6,
          weight: 85,
          stats: [],
        );

        when(
          () => mockGetPokemonDetail(any()),
        ).thenAnswer((_) async => pokemon);

        // Act
        await provider.fetchPokemonDetail(name);

        // Assert
        verify(() => mockGetPokemonDetail(any())).called(1);
      });
    });

    group('State Management', () {
      test('isLoading deve ser true durante carregamento', () async {
        // Arrange
        const pokemon = PokemonEntity(
          id: 1,
          name: 'bulbasaur',
          imageUrl: 'url',
          types: ['grass'],
          height: 7,
          weight: 69,
          stats: [],
        );

        when(
          () => mockGetPokemons(limit: 20, offset: 0),
        ).thenAnswer((_) async => [pokemon]);

        // Act
        final loadingStates = <bool>[];
        provider.addListener(() {
          loadingStates.add(provider.isLoading);
        });

        await provider.fetchPokemons();

        // Assert
        expect(loadingStates.length, 2);
        expect(loadingStates[0], true); // Começa carregando
        expect(loadingStates[1], false); // Termina carregando
      });
    });

    group('reset', () {
      test('deve limpar a lista de pokémons e resetar estados', () async {
        // Arrange
        final pokemons = [
          const PokemonEntity(
            id: 1,
            name: 'bulbasaur',
            imageUrl: 'url',
            types: ['grass'],
            height: 7,
            weight: 69,
            stats: [],
          ),
        ];

        when(
          () => mockGetPokemons(limit: 20, offset: 0),
        ).thenAnswer((_) async => pokemons);

        await provider.fetchPokemons();
        expect(provider.pokemons, isNotEmpty);

        // Act
        provider.reset();

        // Assert
        expect(provider.pokemons, isEmpty);
        expect(provider.hasError, false);
        expect(provider.isLoading, false);
      });

      test('deve notificar listeners ao resetar', () {
        // Arrange
        final notifyCount = <int>[];
        provider.addListener(() => notifyCount.add(1));

        // Act
        provider.reset();

        // Assert
        expect(notifyCount.isNotEmpty, true);
      });
    });
  });
}
