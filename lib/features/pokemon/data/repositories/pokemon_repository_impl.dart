import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_remote_datasource.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDatasource remoteDatasource;

  PokemonRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<PokemonEntity>> getPokemons({
    required int limit,
    required int offset,
  }) {
    return remoteDatasource.getPokemons(limit: limit, offset: offset);
  }

  @override
  Future<PokemonEntity> getPokemonDetail(String name) {
    return remoteDatasource.getPokemonDetail(name);
  }
}
