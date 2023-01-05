import 'package:fulltimeforce_test/pokemon/pokemon_abilities/pokemon_abilities.dart';
import 'package:fulltimeforce_test/shared/url_data/url_data.dart';

class Pokemon {
  final String name;
  final int height;
  final int baseExperience;
  final List<UrlData> forms;
  final List<PokemonAbility> abilities;

  const Pokemon({
    required this.name,
    required this.height,
    required this.baseExperience,
    required this.forms,
    required this.abilities,
  });

  @override
  String toString() {
    return "Pokemon(height=$height,baseExperience=$baseExperience,forms=$forms,abilities=$abilities)";
  }
}
