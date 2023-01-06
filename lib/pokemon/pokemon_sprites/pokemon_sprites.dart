class PokemonSprites {
  final String backDefault;
  final String frontDefault;

  const PokemonSprites({
    required this.backDefault,
    required this.frontDefault,
  });

  @override
  String toString() {
    return "PokemonSprites(backDefault=$backDefault,frontDefault=$frontDefault)";
  }
}
