import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/pokemon/data/datasources/pokemon_remote_datasource.dart';
import '../../features/pokemon/data/datasources/pokemon_remote_datasource_impl.dart';
import '../../features/pokemon/data/repositories/pokemon_repository_impl.dart';
import '../../features/pokemon/domain/repositories/pokemon_repository.dart';
import '../../features/pokemon/domain/usecases/get_pokemons.dart';
import '../../features/pokemon/domain/usecases/get_pokemon_detail.dart';
import '../../features/pokemon/presentation/state/pokemon_provider.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(() => Dio());

  sl.registerLazySingleton<PokemonRemoteDatasource>(
    () => PokemonRemoteDatasourceImpl(sl()),
  );

  sl.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetPokemons(sl()));
  sl.registerLazySingleton(() => GetPokemonDetail(sl()));

  if (!sl.isRegistered<PokemonProvider>()) {
    sl.registerFactory(() => PokemonProvider(sl(), sl()));
  }
}
