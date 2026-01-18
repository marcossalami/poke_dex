import 'pokemon_type.dart';

PokemonType pokemonTypeFromString(String type) {
  return PokemonType.values.firstWhere(
    (e) => e.name == type.toLowerCase(),
    orElse: () => PokemonType.normal,
  );
}
