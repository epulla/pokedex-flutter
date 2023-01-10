import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fulltimeforce_test/evolution_chain/evolution_chain_controller.dart';
import 'package:fulltimeforce_test/pokemon/pokemon/pokemon_controller.dart';
import 'package:fulltimeforce_test/pokemon/pokemon_stat/pokemon_stat.dart';
import 'package:fulltimeforce_test/shared/url_data/url_data.dart';
import 'package:fulltimeforce_test/shared/utils/colors_manipulation.dart';
import 'package:fulltimeforce_test/shared/utils/fetch_data.dart';
import 'package:fulltimeforce_test/shared/utils/string_manipulation.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PokemonScreen extends HookWidget {
  final String uri;
  final String content;
  const PokemonScreen({super.key, required this.uri, required this.content});

  List<Widget> renderPokemonStats(
    List<PokemonStat> pokemonStats,
    double width,
  ) {
    List<Widget> pokemonStatWidgets = [];
    for (var pokemonStat in pokemonStats) {
      pokemonStatWidgets.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: width * 0.3,
                child: Text(
                  capitalize(pokemonStat.stat.name),
                  style: const TextStyle(color: Colors.blueGrey, fontSize: 17),
                ),
              ),
              LinearPercentIndicator(
                animation: true,
                width: width * .3,
                lineHeight: 14.0,
                percent: pokemonStat.baseStat / 255,
                backgroundColor: Colors.grey,
                progressColor: pokemonStat.baseStat >= 0 &&
                        pokemonStat.baseStat < 70
                    ? Colors.red
                    : pokemonStat.baseStat >= 70 && pokemonStat.baseStat < 100
                        ? Colors.yellow
                        : Colors.green,
              ),
              SizedBox(
                width: width * 0.1,
                child: Text(
                  pokemonStat.baseStat.toString(),
                  style: const TextStyle(color: Colors.blueGrey, fontSize: 17),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return pokemonStatWidgets;
  }

  List<Widget> renderPokemonTypes(List<UrlData> types) {
    List<Widget> elements = [];
    for (var type in types) {
      elements.add(
        DecoratedBox(
          decoration: BoxDecoration(
            color: getTypeColor(type.name),
            borderRadius: BorderRadius.circular(5),
            shape: BoxShape.rectangle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              capitalize(
                type.name,
              ),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
    }
    return elements;
  }

  List<Widget> renderEvolutionChain(List<UrlData> evolutionChain) {
    List<Widget> elems = [];
    for (var obj in evolutionChain) {
      elems.add(HookBuilder(
        builder: (context) {
          final pokemon = useState<dynamic>(null);
          final pokemonRawData = useState<dynamic>("");
          useEffect(() {
            if (pokemon.value == null) {
              fetchData(
                  pokemon,
                  "https://pokeapi.co/api/v2/pokemon/${obj.name}",
                  parseToPokemonSimplified,
                  dataState: pokemonRawData);
            }
            return () {};
          }, [pokemon.value]);

          if (pokemon.value == null) {
            return const Center(
              widthFactor: .3,
              child: CircularProgressIndicator(),
            );
          }

          return GestureDetector(
            onTap: () {
              GoRouter.of(context).goNamed("pokemon-details", queryParams: {
                "uri": uri,
                "content": json.encode(pokemonRawData.value),
              });
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color.fromARGB(108, 180, 180, 180),
                borderRadius: BorderRadius.circular(5),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Text(
                      capitalize(pokemon.value.name),
                      style:
                          const TextStyle(color: Colors.blueGrey, fontSize: 17),
                    ),
                    CachedNetworkImage(
                      imageUrl: pokemon.value.sprites.officialFrontDefault,
                      height: 100,
                      fit: BoxFit.fitHeight,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ));
    }
    return elems;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final pokemon = parseToPokemon(json.decode(content));

    final specie = useState<dynamic>(null);

    final evolutionChainRawData = useState<dynamic>(null);

    final evolutionChain = useState<dynamic>(null);

    useEffect(() {
      if (specie.value == null) {
        fetchData(specie, pokemon.specie.url, (json) => json);
      }
      if (specie.value != null && evolutionChainRawData.value == null) {
        fetchData(evolutionChainRawData, specie.value['evolution_chain']['url'],
            (json) => json);
      }
      if (evolutionChainRawData.value != null) {
        evolutionChain.value =
            getAllEvolutionChain(evolutionChainRawData.value);
      }
      return () {};
    }, [specie.value, evolutionChainRawData.value, evolutionChain.value]);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: getTypeColor(pokemon.types[0].name),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height * 1.6,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 20,
                left: 5,
                child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              Positioned(
                top: height * 0.18,
                right: -30,
                child: Image.asset(
                  'images/pokeball.png',
                  height: 200,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: width,
                  height: height * 1.2,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.3,
                                child: const Text(
                                  'Name',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 17),
                                ),
                              ),
                              Text(
                                capitalize(pokemon.name),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.3,
                                child: const Text(
                                  'Height',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 17),
                                ),
                              ),
                              Text(
                                "${pokemon.height / 10} m",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.3,
                                child: const Text(
                                  'Weight',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 17),
                                ),
                              ),
                              Text(
                                "${pokemon.weight / 10} kg",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.3,
                                child: const Text(
                                  'Stats',
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: renderPokemonStats(
                            pokemon.stats,
                            width,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.3,
                                child: const Text(
                                  'Types',
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            spacing: 10,
                            children: renderPokemonTypes(pokemon.types),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.4,
                                child: const Text(
                                  'Evolution Chain',
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Builder(builder: ((context) {
                          if (evolutionChain.value == null) {
                            return const Center(
                              widthFactor: .3,
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              spacing: 10,
                              children:
                                  renderEvolutionChain(evolutionChain.value),
                            ),
                          );
                        })),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: (height * 0.2),
                left: (width / 2) - 100,
                child: Hero(
                  tag: pokemon.name,
                  child: CachedNetworkImage(
                    height: 200,
                    width: 200,
                    imageUrl: pokemon.sprites.officialFrontDefault,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
