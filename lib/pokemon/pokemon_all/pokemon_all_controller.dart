import 'package:fulltimeforce_test/pokemon/pokemon_all/pokemon_all.dart';
import 'package:fulltimeforce_test/shared/url_data/url_data_controller.dart';

PokemonAll parseToPokemonAll(Map<String, dynamic> json) {
  var pokemons = parseToUrlDataList(json['results']);
  return PokemonAll(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      pokemons: pokemons);
}
