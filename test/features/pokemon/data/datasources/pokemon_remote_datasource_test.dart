import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:poke_dex/features/pokemon/data/datasources/pokemon_remote_datasource_impl.dart';
import 'package:poke_dex/features/pokemon/data/models/pokemon_model.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late PokemonRemoteDatasourceImpl datasource;

  setUp(() {
    mockDio = MockDio();
    datasource = PokemonRemoteDatasourceImpl(mockDio);
  });

  group('PokemonRemoteDatasourceImpl', () {
    group('getPokemons', () {
      test(
        'deve retornar lista de pokémons quando a requisição é bem-sucedida',
        () async {
          // Arrange
          const limit = 20;
          const offset = 0;
          final mockResponse = Response(
            requestOptions: RequestOptions(path: ''),
            data: {
              'results': [
                {
                  'name': 'bulbasaur',
                  'url': 'https://pokeapi.co/api/v2/pokemon/1/',
                },
              ],
            },
            statusCode: 200,
          );

          final mockDetailResponse = Response(
            requestOptions: RequestOptions(path: ''),
            data: {
              'id': 1,
              'name': 'bulbasaur',
              'sprites': {
                'other': {
                  'official-artwork': {'front_default': ''},
                },
              },
              'types': [
                {
                  'type': {'name': 'grass'},
                },
              ],
              'height': 7,
              'weight': 69,
              'stats': [],
            },
            statusCode: 200,
          );

          when(
            () => mockDio.get(
              'https://pokeapi.co/api/v2/pokemon',
              queryParameters: {'limit': limit, 'offset': offset},
            ),
          ).thenAnswer((_) async => mockResponse);

          when(
            () => mockDio.get('https://pokeapi.co/api/v2/pokemon/1/'),
          ).thenAnswer((_) async => mockDetailResponse);

          // Act
          final result = await datasource.getPokemons(
            limit: limit,
            offset: offset,
          );

          // Assert
          expect(result, isA<List<PokemonModel>>());
          expect(result.isNotEmpty, true);
          verify(
            () => mockDio.get(
              'https://pokeapi.co/api/v2/pokemon',
              queryParameters: {'limit': limit, 'offset': offset},
            ),
          ).called(1);
        },
      );

      test('deve lançar exceção quando a requisição falha', () async {
        // Arrange
        const limit = 20;
        const offset = 0;

        when(
          () => mockDio.get(
            'https://pokeapi.co/api/v2/pokemon',
            queryParameters: {'limit': limit, 'offset': offset},
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            error: 'erro',
          ),
        );

        // Act & Assert
        expect(
          () => datasource.getPokemons(limit: limit, offset: offset),
          throwsException,
        );
      });
    });

    group('getPokemonDetail', () {
      test('deve retornar detalhes do pokémon quando bem-sucedido', () async {
        // Arrange
        const name = 'bulbasaur';
        final mockResponse = Response(
          requestOptions: RequestOptions(path: ''),
          data: {
            'id': 1,
            'name': 'bulbasaur',
            'sprites': {
              'other': {
                'official-artwork': {'front_default': ''},
              },
            },
            'types': [
              {
                'type': {'name': 'grass'},
              },
            ],
            'height': 7,
            'weight': 69,
            'stats': [],
          },
          statusCode: 200,
        );

        when(
          () => mockDio.get('https://pokeapi.co/api/v2/pokemon/$name'),
        ).thenAnswer((_) async => mockResponse);

        // Act
        final result = await datasource.getPokemonDetail(name);

        // Assert
        expect(result, isA<PokemonModel>());
        expect(result.name, name);
        verify(
          () => mockDio.get('https://pokeapi.co/api/v2/pokemon/$name'),
        ).called(1);
      });

      test('deve lançar exceção quando o pokémon não é encontrado', () async {
        // Arrange
        const name = 'pokemon_inexistente';

        when(
          () => mockDio.get('https://pokeapi.co/api/v2/pokemon/$name'),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            response: Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 404,
            ),
          ),
        );

        // Act & Assert
        expect(() => datasource.getPokemonDetail(name), throwsException);
      });
    });
  });
}
