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
          _scrollController.position.maxScrollExtent - 300) {
        context.read<PokemonProvider>().fetchPokemons();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onRefresh() {
    final provider = context.read<PokemonProvider>();
    provider.reset();
    provider.fetchPokemons();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PokemonProvider>();

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: RefreshIndicator(
        onRefresh: () async => _onRefresh(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 140,
              backgroundColor: Colors.red[700],
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Pokédex',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Descubra todos os Pokémons',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),

            if (provider.hasError && provider.pokemons.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cloud_off, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(
                        'Erro ao carregar Pokémon',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Verifique sua conexão e tente novamente',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => provider.fetchPokemons(),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Tentar Novamente'),
                      ),
                    ],
                  ),
                ),
              )
            else ...[
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Selecione um Pokémon',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
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
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(strokeWidth: 3),
                        ),
                      );
                    },
                    childCount:
                        provider.pokemons.length + (provider.isLoading ? 2 : 0),
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                ),
              ),

              const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
            ],
          ],
        ),
      ),
    );
  }
}
