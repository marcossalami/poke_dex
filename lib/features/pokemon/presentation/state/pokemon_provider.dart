import 'package:flutter/material.dart';
import 'package:poke_dex/features/pokemon/domain/usecases/get_pokemon_detail.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/usecases/get_pokemons.dart';

class PokemonProvider extends ChangeNotifier {
  final GetPokemons getPokemons;
  final GetPokemonDetail getPokemonDetail;

  PokemonProvider(this.getPokemons, this.getPokemonDetail);

  final List<PokemonEntity> _pokemons = [];

  final Map<String, PokemonEntity> _detailsCache = {};

  List<PokemonEntity> get pokemons => _pokemons;

  bool isLoading = false;
  bool hasError = false;

  int _offset = 0;
  final int _limit = 20;
  bool _hasReachedEnd = false;

  Future<void> fetchPokemons() async {
    if (isLoading || _hasReachedEnd) return;

    isLoading = true;
    hasError = false;
    notifyListeners();

    try {
      final result = await getPokemons(limit: _limit, offset: _offset);

      if (result.isEmpty) {
        _hasReachedEnd = true;
      } else {
        _pokemons.addAll(result);
        _offset += _limit;
      }
    } catch (_) {
      hasError = true;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<PokemonEntity?> fetchPokemonDetail(String name) async {
    if (_detailsCache.containsKey(name)) {
      return _detailsCache[name];
    }

    try {
      final pokemon = await getPokemonDetail(
        GetPokemonDetailParams(name: name),
      );
      _detailsCache[name] = pokemon;
      return pokemon;
    } catch (_) {
      return null;
    }
  }

  void reset() {
    _pokemons.clear();
    _offset = 0;
    _hasReachedEnd = false;
    hasError = false;
    isLoading = false;
    notifyListeners();
  }
}
