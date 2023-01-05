import 'package:fulltimeforce_test/shared/url_data/url_data.dart';

class PokemonAbility {
  final UrlData urlData;
  final bool isHidden;
  final int slot;

  const PokemonAbility({
    required this.urlData,
    required this.isHidden,
    required this.slot,
  });

  @override
  String toString() {
    return "PokemonAbility(urlData=$urlData,isHidden=$isHidden,slot=$slot)";
  }
}
