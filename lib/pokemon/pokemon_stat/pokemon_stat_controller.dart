import 'package:fulltimeforce_test/pokemon/pokemon_stat/pokemon_stat.dart';
import 'package:fulltimeforce_test/shared/url_data/url_data_controller.dart';

PokemonStat parseToPokemonStat(Map<String, dynamic> json) {
  return PokemonStat(
      baseStat: json['base_stat'],
      effort: json['effort'],
      stat: parseToUrlData(json['stat']));
}

List<PokemonStat> parseToPokemonStats(List<dynamic> json) {
  List<PokemonStat> stats = [];
  for (var obj in json) {
    stats.add(parseToPokemonStat(obj as Map<String, dynamic>));
  }
  return stats;
}
