import '../entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonDetail {
  final PokemonRepository repository;

  GetPokemonDetail(this.repository);

  Future<PokemonEntity> call(GetPokemonDetailParams params) {
    return repository.getPokemonDetail(params.name);
  }
}

class GetPokemonDetailParams {
  final String name;

  GetPokemonDetailParams({required this.name});
}
