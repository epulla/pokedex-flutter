import 'package:fulltimeforce_test/shared/url_data/url_data.dart';

class PokemonGameIndex {
  final int gameIndex;
  final UrlData version;

  const PokemonGameIndex({
    required this.gameIndex,
    required this.version,
  });

  @override
  String toString() {
    return "PokemonGameIndex(gameIndex=$gameIndex,version=$version)";
  }
}
