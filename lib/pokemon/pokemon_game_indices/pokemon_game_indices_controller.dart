import 'package:fulltimeforce_test/pokemon/pokemon_game_indices/pokemon_game_index.dart';
import 'package:fulltimeforce_test/shared/url_data/url_data_controller.dart';

PokemonGameIndex parseToPokemonGameIndex(Map<String, dynamic> json) {
  var urlData = parseToUrlData(json['version']);
  return PokemonGameIndex(
    gameIndex: json['game_index'],
    version: urlData,
  );
}

List<PokemonGameIndex> parseToPokemonGameIndices(List<dynamic> json) {
  List<PokemonGameIndex> gameIndices = [];
  for (var obj in json) {
    gameIndices.add(parseToPokemonGameIndex(obj as Map<String, dynamic>));
  }
  return gameIndices;
}
