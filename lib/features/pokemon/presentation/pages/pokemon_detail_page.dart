import 'package:flutter/material.dart';
import 'package:poke_dex/core/enums/pokemon_type.dart';
import 'package:poke_dex/core/enums/pokemon_type_extension.dart';
import 'package:poke_dex/core/enums/pokemon_type_parser.dart';
import 'package:poke_dex/features/pokemon/presentation/pages/pokemon_detail_skeleton.dart';
import 'package:poke_dex/features/pokemon/presentation/widgets/info_column.dart';
import 'package:poke_dex/features/pokemon/presentation/widgets/pokemon_stat_bar.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../state/pokemon_provider.dart';

class PokemonDetailPage extends StatelessWidget {
  final String pokemonName;

  const PokemonDetailPage({super.key, required this.pokemonName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PokemonEntity?>(
        future: context.read<PokemonProvider>().fetchPokemonDetail(pokemonName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const PokemonDetailSkeleton();
          }

          final pokemon = snapshot.data;

          if (pokemon == null) {
            return const Center(child: Text('Erro ao carregar Pokémon'));
          }

          final primaryType = pokemon.types.isNotEmpty
              ? pokemonTypeFromString(pokemon.types.first)
              : PokemonType.normal;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryType.color,
                  primaryType.color.withValues(alpha: 0.75),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Spacer(),
                        Text(
                          pokemon.name.toUpperCase(),
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.3,
                              ),
                        ),
                        const Spacer(flex: 2),
                      ],
                    ),
                  ),

                  Hero(
                    tag: pokemon.name,
                    child: Image.network(
                      pokemon.imageUrl,
                      height: 240,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                      ),
                      child: Column(
                        children: [
                          Wrap(
                            spacing: 10,
                            children: pokemon.types.map((type) {
                              final enumType = pokemonTypeFromString(type);

                              return Chip(
                                avatar: Icon(
                                  enumType.icon,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  enumType.labelPtBr,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: enumType.color.withValues(
                                  alpha: 0.9,
                                ),
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 28),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InfoColumn(
                                label: 'ALTURA',
                                value: '${pokemon.height / 10} m',
                              ),
                              InfoColumn(
                                label: 'PESO',
                                value: '${pokemon.weight / 10} kg',
                              ),
                            ],
                          ),
                          const SizedBox(height: 28),

                          Column(
                            children: pokemon.stats.map((stat) {
                              return PokemonStatBar(
                                stat: stat,
                                color: primaryType.color,
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
