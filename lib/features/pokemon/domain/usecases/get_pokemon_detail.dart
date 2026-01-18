import '../../../../core/usecase/usecase.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonDetail
    implements UseCase<PokemonEntity, GetPokemonDetailParams> {
  final PokemonRepository repository;

  GetPokemonDetail(this.repository);

  @override
  Future<PokemonEntity> call(GetPokemonDetailParams params) {
    return repository.getPokemonDetail(params.name);
  }
}

class GetPokemonDetailParams {
  final String name;

  GetPokemonDetailParams({required this.name});
}
