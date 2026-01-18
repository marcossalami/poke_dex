import 'package:poke_dex/features/pokemon/domain/entities/pokemon_stat_entity.dart';

import '../../domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  const PokemonModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.types,
    required super.height,
    required super.weight,
    required super.stats,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      name: json['name'],
      imageUrl:
          json['sprites']['other']['official-artwork']['front_default'] ?? '',
      types: (json['types'] as List)
          .map((e) => e['type']['name'] as String)
          .toList(),
      height: json['height'],
      weight: json['weight'],
      stats: (json['stats'] as List)
          .map(
            (e) => PokemonStatEntity(
              name: e['stat']['name'],
              value: e['base_stat'],
            ),
          )
          .toList(),
    );
  }
}
