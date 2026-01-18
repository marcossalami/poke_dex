import 'package:flutter/material.dart';
import 'pokemon_type.dart';

extension PokemonTypeExtension on PokemonType {
  String get labelPtBr {
    switch (this) {
      case PokemonType.fire:
        return 'Fogo';
      case PokemonType.water:
        return 'Água';
      case PokemonType.grass:
        return 'Planta';
      case PokemonType.electric:
        return 'Elétrico';
      case PokemonType.psychic:
        return 'Psíquico';
      case PokemonType.rock:
        return 'Pedra';
      case PokemonType.ground:
        return 'Terra';
      case PokemonType.bug:
        return 'Inseto';
      case PokemonType.ghost:
        return 'Fantasma';
      case PokemonType.ice:
        return 'Gelo';
      case PokemonType.dragon:
        return 'Dragão';
      case PokemonType.fighting:
        return 'Lutador';
      case PokemonType.poison:
        return 'Veneno';
      case PokemonType.flying:
        return 'Voador';
      case PokemonType.dark:
        return 'Sombrio';
      case PokemonType.steel:
        return 'Aço';
      case PokemonType.fairy:
        return 'Fada';
      case PokemonType.normal:
        return 'Normal';
    }
  }

  Color get color {
    switch (this) {
      case PokemonType.fire:
        return Colors.redAccent;
      case PokemonType.water:
        return Colors.blueAccent;
      case PokemonType.grass:
        return Colors.green;
      case PokemonType.electric:
        return Colors.amber;
      case PokemonType.psychic:
        return Colors.purpleAccent;
      case PokemonType.rock:
        return Colors.brown;
      case PokemonType.ground:
        return Colors.orange;
      case PokemonType.bug:
        return Colors.lightGreen;
      case PokemonType.ghost:
        return Colors.deepPurple;
      case PokemonType.ice:
        return Colors.cyan;
      case PokemonType.dragon:
        return Colors.indigo;
      case PokemonType.fighting:
        return Colors.deepOrange;
      case PokemonType.poison:
        return Colors.deepPurple;
      case PokemonType.flying:
        return Colors.lightBlue;
      case PokemonType.dark:
        return Colors.grey[800]!;
      case PokemonType.steel:
        return Colors.blueGrey;
      case PokemonType.fairy:
        return Colors.pink;
      case PokemonType.normal:
        return Colors.grey;
    }
  }

  IconData get icon {
    switch (this) {
      case PokemonType.fire:
        return Icons.local_fire_department;
      case PokemonType.water:
        return Icons.water_drop;
      case PokemonType.grass:
        return Icons.grass;
      case PokemonType.electric:
        return Icons.flash_on;
      case PokemonType.psychic:
        return Icons.visibility;
      case PokemonType.rock:
        return Icons.terrain;
      case PokemonType.ground:
        return Icons.landscape;
      case PokemonType.bug:
        return Icons.bug_report;
      case PokemonType.ghost:
        return Icons.blur_on;
      case PokemonType.ice:
        return Icons.ac_unit;
      case PokemonType.dragon:
        return Icons.whatshot;
      case PokemonType.fighting:
        return Icons.sports_mma;
      case PokemonType.poison:
        return Icons.warning_amber;
      case PokemonType.flying:
        return Icons.air;
      case PokemonType.dark:
        return Icons.dark_mode;
      case PokemonType.steel:
        return Icons.shield;
      case PokemonType.fairy:
        return Icons.spa;
      case PokemonType.normal:
        return Icons.circle;
    }
  }
}
