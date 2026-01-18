import '../../../../core/usecase/usecase.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemons implements UseCase<List<PokemonEntity>, GetPokemonsParams> {
  final PokemonRepository repository;

  GetPokemons(this.repository);

  @override
  Future<List<PokemonEntity>> call(GetPokemonsParams params) {
    return repository.getPokemons(limit: params.limit, offset: params.offset);
  }
}

class GetPokemonsParams {
  final int limit;
  final int offset;

  GetPokemonsParams({required this.limit, required this.offset});
}
