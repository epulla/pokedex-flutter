import 'package:fulltimeforce_test/pokemon/pokemon/pokemon.dart';
import 'package:fulltimeforce_test/pokemon/pokemon/pokemon_simplified.dart';
import 'package:fulltimeforce_test/pokemon/pokemon_sprites/pokemon_sprites_controller.dart';
import 'package:fulltimeforce_test/pokemon/pokemon_stat/pokemon_stat_controller.dart';
import 'package:fulltimeforce_test/shared/url_data/url_data_controller.dart';

Pokemon parseToPokemon(Map<String, dynamic> json) {
  return Pokemon(
    name: json['name'],
    height: json['height'],
    weight: json['weight'],
    baseExperience: json['base_experience'],
    moves: parseToUrlDataList(json['moves'], subkey: 'move'),
    sprites: parseToPokemonSprites(json['sprites']),
    types: parseToUrlDataList(json['types'], subkey: 'type'),
    stats: parseToPokemonStats(json['stats']),
    specie: parseToUrlData(json['species']),
  );
}

PokemonSimplified parseToPokemonSimplified(Map<String, dynamic> json) {
  return PokemonSimplified(
    name: json['name'],
    sprites: parseToPokemonSprites(json['sprites']),
    types: parseToUrlDataList(json['types'], subkey: 'type'),
  );
}
