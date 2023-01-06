import 'package:fulltimeforce_test/pokemon/pokemon_sprites/pokemon_sprites.dart';

PokemonSprites parseToPokemonSprites(Map<String, dynamic> json) {
  return PokemonSprites(
    officialFrontDefault: json['other']['official-artwork']['front_default'],
  );
}
