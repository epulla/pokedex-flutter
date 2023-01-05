import 'package:fulltimeforce_test/pokemon/pokemon_abilities/pokemon_abilities.dart';
import 'package:fulltimeforce_test/shared/url_data/url_data_controller.dart';

PokemonAbility parseToPokemonAbility(Map<String, dynamic> json) {
  var urlData = parseToUrlData(json['ability']);
  return PokemonAbility(
    urlData: urlData,
    isHidden: json['is_hidden'],
    slot: json['slot'],
  );
}

List<PokemonAbility> parseToPokemonAbilities(List<dynamic> json) {
  List<PokemonAbility> abilities = [];
  for (var obj in json) {
    abilities.add(parseToPokemonAbility(obj as Map<String, dynamic>));
  }
  return abilities;
}
