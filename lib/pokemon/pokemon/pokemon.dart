import 'package:fulltimeforce_test/pokemon/pokemon_sprites/pokemon_sprites.dart';
import 'package:fulltimeforce_test/pokemon/pokemon_stat/pokemon_stat.dart';
import 'package:fulltimeforce_test/shared/url_data/url_data.dart';

class Pokemon {
  final String name;
  final int height;
  final int weight;
  final int baseExperience;
  final List<UrlData> moves;
  final PokemonSprites sprites;
  final List<UrlData> types;
  final List<PokemonStat> stats;
  final UrlData specie;

  const Pokemon({
    required this.name,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.moves,
    required this.sprites,
    required this.types,
    required this.stats,
    required this.specie,
  });

  @override
  String toString() {
    return "Pokemon(name=$name,height=$height,baseExperience=$baseExperience,moves=$moves,sprites=$sprites,types=$types,stats=$stats,specie=$specie)";
  }
}
