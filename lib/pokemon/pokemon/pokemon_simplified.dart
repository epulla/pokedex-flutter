import 'package:fulltimeforce_test/pokemon/pokemon_sprites/pokemon_sprites.dart';
import 'package:fulltimeforce_test/shared/url_data/url_data.dart';

class PokemonSimplified {
  final String name;
  final PokemonSprites sprites;
  final List<UrlData> types;

  const PokemonSimplified({
    required this.name,
    required this.sprites,
    required this.types,
  });

  @override
  String toString() {
    return "Pokemon(name=$name,sprites=$sprites,types=$types)";
  }
}
