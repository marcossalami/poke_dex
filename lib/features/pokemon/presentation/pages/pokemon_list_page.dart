import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/pokemon_provider.dart';
import '../widgets/pokemon_card.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<PokemonProvider>().fetchPokemons();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PokemonProvider>();

    if (provider.hasError) {
      return const Scaffold(
        body: Center(child: Text('Erro ao carregar Pokémons')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex')),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: provider.pokemons.length + 1,
        itemBuilder: (context, index) {
          if (index < provider.pokemons.length) {
            return PokemonCard(pokemon: provider.pokemons[index]);
          }
          return provider.isLoading
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
