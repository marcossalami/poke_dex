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

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 88,
        title: Column(
          children: const [
            Text(
              'Pokédex',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 4),
            Text('Descubra todos os Pokémons', style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
      body: provider.hasError
          ? const Center(child: Text('Erro ao carregar Pokémons'))
          : Column(
              children: [
                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Selecione um Pokémon',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  height: 260,
                  child: Center(
                    child: ListView.separated(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount:
                          provider.pokemons.length +
                          (provider.isLoading ? 1 : 0),
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        if (index < provider.pokemons.length) {
                          final pokemon = provider.pokemons[index];

                          return PokemonCard(
                            pokemon: pokemon,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/detail',
                                arguments: pokemon.name,
                              );
                            },
                          );
                        }

                        return const Center(
                          child: SizedBox(
                            width: 48,
                            height: 48,
                            child: CircularProgressIndicator(strokeWidth: 3),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
