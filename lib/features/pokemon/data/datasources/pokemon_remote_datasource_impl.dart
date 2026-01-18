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
  }

  @override
  Future<PokemonModel> getPokemonDetail(String name) async {
    final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$name');
    return PokemonModel.fromJson(response.data);
  }
}
