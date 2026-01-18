import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/di/injector.dart' as di;
import 'features/pokemon/presentation/pages/pokemon_list_page.dart';
import 'features/pokemon/presentation/state/pokemon_provider.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => di.sl<PokemonProvider>()..fetchPokemons(),
      child: MaterialApp(
        title: 'Pokédex',
        theme: ThemeData(useMaterial3: true),
        home: const PokemonListPage(),
      ),
    );
  }
}
