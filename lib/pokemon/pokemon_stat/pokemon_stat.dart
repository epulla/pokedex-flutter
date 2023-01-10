import 'package:fulltimeforce_test/shared/url_data/url_data.dart';

class PokemonStat {
  final int baseStat;
  final int effort;
  final UrlData stat;

  PokemonStat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  @override
  String toString() {
    return "PokemonStat(baseStat=$baseStat,effort=$effort,stat=$stat)";
  }
}
