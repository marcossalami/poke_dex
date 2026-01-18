import 'package:dio/dio.dart';
import '../models/pokemon_model.dart';
import 'pokemon_remote_datasource.dart';

class PokemonRemoteDatasourceImpl implements PokemonRemoteDatasource {
  final Dio dio;

  PokemonRemoteDatasourceImpl(this.dio);

  @override
  Future<List<PokemonModel>> getPokemons({
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await dio.get(
        'https://pokeapi.co/api/v2/pokemon',
        queryParameters: {'limit': limit, 'offset': offset},
      );

      final results = response.data['results'] as List;

      final pokemons = await Future.wait(
        results.map((pokemon) async {
          final detail = await dio.get(pokemon['url']);
          return PokemonModel.fromJson(detail.data);
        }),
      );

      return pokemons;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  @override
  Future<PokemonModel> getPokemonDetail(String name) async {
    try {
      final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$name');
      return PokemonModel.fromJson(response.data);
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  void _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      throw Exception('Tempo de conexão esgotado. Tente novamente.');
    } else if (e.type == DioExceptionType.unknown) {
      throw Exception('Erro de conexão. Verifique sua internet.');
    } else if (e.response?.statusCode == 404) {
      throw Exception('Pokémon não encontrado.');
    } else if (e.response?.statusCode == 500) {
      throw Exception('Erro no servidor. Tente mais tarde.');
    }
  }
}
