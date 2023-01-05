import 'package:fulltimeforce_test/shared/url_data/url_data.dart';

class PokemonAll {
  final int count;
  final String? next; // Next url
  final String? previous; // Previous url
  final List<UrlData> pokemons;

  const PokemonAll({
    required this.count,
    required this.next,
    required this.previous,
    required this.pokemons,
  });

  @override
  String toString() {
    return "PokemonAll(count=$count,next=$next,previous=$previous,pokemons=$pokemons)";
  }
}
