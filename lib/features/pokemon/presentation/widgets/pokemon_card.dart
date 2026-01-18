import 'package:flutter/material.dart';
import 'package:poke_dex/features/pokemon/presentation/pages/pokemon_detail_page.dart';
import '../../domain/entities/pokemon_entity.dart';

class PokemonCard extends StatelessWidget {
  final PokemonEntity pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Image.network(
          pokemon.imageUrl,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
        ),
        title: Text(pokemon.name.toUpperCase()),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PokemonDetailPage(pokemonName: pokemon.name),
            ),
          );
        },
      ),
    );
  }
}
