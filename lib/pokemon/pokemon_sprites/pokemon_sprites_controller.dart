import 'package:fulltimeforce_test/pokemon/pokemon_sprites/pokemon_sprites.dart';

PokemonSprites parseToPokemonSprites(Map<String, dynamic> json) {
  return PokemonSprites(
    backDefault: json['back_default'],
    frontDefault: json['front_default'],
  );
}
