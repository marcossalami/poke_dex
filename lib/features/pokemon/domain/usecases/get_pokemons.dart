import '../entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemons {
  final PokemonRepository repository;

  GetPokemons(this.repository);

  Future<List<PokemonEntity>> call({required int limit, required int offset}) {
    return repository.getPokemons(limit: limit, offset: offset);
  }
}
