import 'package:flutter/material.dart';
import 'package:poke_dex/core/enums/pokemon_type.dart';
import 'package:poke_dex/core/enums/pokemon_type_extension.dart';
import 'package:poke_dex/core/enums/pokemon_type_parser.dart';
import '../../domain/entities/pokemon_entity.dart';

class PokemonCard extends StatelessWidget {
  final PokemonEntity pokemon;
  final VoidCallback? onTap;

  const PokemonCard({super.key, required this.pokemon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final primaryType = pokemon.types.isNotEmpty
        ? pokemonTypeFromString(pokemon.types.first)
        : PokemonType.normal;

    return SizedBox(
      width: 170,
      child: Card(
        elevation: 8,
        color: primaryType.color.withValues(alpha: .9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// IMAGE
                Expanded(
                  child: Hero(
                    tag: pokemon.name,
                    child: Image.network(
                      pokemon.imageUrl,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.image_not_supported,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                /// NAME
                Text(
                  pokemon.name.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 8),

                /// TYPES
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  alignment: WrapAlignment.center,
                  children: pokemon.types.map((type) {
                    final enumType = pokemonTypeFromString(type);

                    return Chip(
                      avatar: Icon(
                        enumType.icon,
                        size: 14,
                        color: Colors.white,
                      ),
                      label: Text(
                        enumType.labelPtBr,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: enumType.color.withValues(alpha: 0.85),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
