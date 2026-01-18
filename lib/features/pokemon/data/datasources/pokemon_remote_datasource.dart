import '../models/pokemon_model.dart';

abstract class PokemonRemoteDatasource {
  Future<List<PokemonModel>> getPokemons({
    required int limit,
    required int offset,
  });

  Future<PokemonModel> getPokemonDetail(String name);
}
