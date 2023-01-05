import 'package:fulltimeforce_test/pokemon/pokemon/pokemon.dart';
import 'package:fulltimeforce_test/pokemon/pokemon_abilities/pokemon_abilities_controller.dart';
import 'package:fulltimeforce_test/shared/url_data/url_data_controller.dart';

Pokemon parseToPokemon(Map<String, dynamic> json) {
  return Pokemon(
    name: json['name'],
    height: json['height'],
    baseExperience: json['base_experience'],
    forms: parseToUrlDataList(json['forms']),
    abilities: parseToPokemonAbilities(json['abilities']),
  );
}
