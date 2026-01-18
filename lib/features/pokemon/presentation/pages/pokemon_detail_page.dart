import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../state/pokemon_provider.dart';

class PokemonDetailPage extends StatelessWidget {
  final String pokemonName;

  const PokemonDetailPage({super.key, required this.pokemonName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pokemonName.toUpperCase())),
      body: FutureBuilder<PokemonEntity?>(
        future: context.read<PokemonProvider>().fetchPokemonDetail(pokemonName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final pokemon = snapshot.data;

          if (pokemon == null) {
            return const Center(child: Text('Erro ao carregar Pokémon'));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(pokemon.imageUrl, height: 200),
                const SizedBox(height: 16),
                Text(
                  pokemon.name.toUpperCase(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text('Altura: ${pokemon.height}'),
                Text('Peso: ${pokemon.weight}'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: pokemon.types
                      .map((type) => Chip(label: Text(type)))
                      .toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
