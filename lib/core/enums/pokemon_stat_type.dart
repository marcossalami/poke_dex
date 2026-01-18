enum PokemonStatType {
  hp,
  attack,
  defense,
  specialAttack,
  specialDefense,
  speed,
}

PokemonStatType pokemonStatFromString(String stat) {
  switch (stat) {
    case 'hp':
      return PokemonStatType.hp;
    case 'attack':
      return PokemonStatType.attack;
    case 'defense':
      return PokemonStatType.defense;
    case 'special-attack':
      return PokemonStatType.specialAttack;
    case 'special-defense':
      return PokemonStatType.specialDefense;
    case 'speed':
      return PokemonStatType.speed;
    default:
      return PokemonStatType.hp;
  }
}

extension PokemonStatTypeExtension on PokemonStatType {
  String get labelPtBr {
    switch (this) {
      case PokemonStatType.hp:
        return 'HP';
      case PokemonStatType.attack:
        return 'Ataque';
      case PokemonStatType.defense:
        return 'Defesa';
      case PokemonStatType.specialAttack:
        return 'Ataque Esp.';
      case PokemonStatType.specialDefense:
        return 'Defesa Esp.';
      case PokemonStatType.speed:
        return 'Velocidade';
    }
  }
}
