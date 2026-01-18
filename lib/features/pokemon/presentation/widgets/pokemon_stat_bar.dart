import 'package:flutter/material.dart';
import 'package:poke_dex/core/enums/pokemon_stat_type.dart';
import '../../domain/entities/pokemon_stat_entity.dart';

class PokemonStatBar extends StatelessWidget {
  final PokemonStatEntity stat;
  final Color color;

  const PokemonStatBar({super.key, required this.stat, required this.color});

  @override
  Widget build(BuildContext context) {
    final statType = pokemonStatFromString(stat.name);
    final normalizedValue = stat.value / 150;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              statType.labelPtBr,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: normalizedValue),
              duration: const Duration(milliseconds: 900),
              builder: (_, value, __) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: LinearProgressIndicator(
                    value: value.clamp(0, 1),
                    color: color,
                    backgroundColor: color.withValues(alpha: 0.2),
                    minHeight: 10,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          Text(
            stat.value.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
