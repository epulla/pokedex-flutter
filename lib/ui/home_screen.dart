import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fulltimeforce_test/pokemon/pokemon/pokemon_controller.dart';
import 'package:fulltimeforce_test/pokemon/pokemon_all/pokemon_all_controller.dart';
import 'package:fulltimeforce_test/shared/utils/colors_manipulation.dart';
import 'package:fulltimeforce_test/shared/utils/fetch_data.dart';
import 'package:fulltimeforce_test/shared/utils/string_manipulation.dart';
import 'package:go_router/go_router.dart';

const int limit = 8;

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  final String allPokemonsUri =
      "https://pokeapi.co/api/v2/pokemon?limit=$limit&offset=0";

  List<Widget> renderPrimaryTypes(List<dynamic> types, {int limit = 2}) {
    List<Widget> elements = [];
    int i = 0;
    for (var type in types) {
      if (i >= limit) {
        break;
      }
      elements.add(
        DecoratedBox(
          decoration: BoxDecoration(
            color: const Color.fromARGB(94, 255, 255, 255),
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
                fontSize: 10,
              ),
            ),
          ),
        ),
      );
      i++;
    }
    return elements;
  }

  @override
  Widget build(BuildContext context) {
    final pagePokemonUri = useState(allPokemonsUri);
    final allPokemons = useState<dynamic>(null);

    useEffect(() {
      fetchData(allPokemons, pagePokemonUri.value, parseToPokemonAll);
      return () {};
    }, [allPokemons.value, pagePokemonUri.value]);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Positioned(
          top: -50,
          right: -50,
          child: Image.asset(
            'images/pokeball.png',
            width: 200,
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned(
          top: 90,
          left: 35,
          child: Text(
            'Pokedex',
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Positioned(
          top: 130,
          bottom: 0,
          width: MediaQuery.of(context).size.width,
          child: Builder(
            builder: (context) {
              if (allPokemons.value == null) {
                return const Center(
                  widthFactor: .3,
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: CupertinoScrollbar(
                      child: GridView.builder(
                        // shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        itemCount: limit,
                        itemBuilder: (context, index) {
                          final String name =
                              allPokemons.value.pokemons[index].name;
                          final String uri =
                              allPokemons.value.pokemons[index].url;
                          return HookBuilder(
                            builder: (context) {
                              final pokemon = useState<dynamic>(null);
                              final pokemonRawData = useState<dynamic>("");
                              useEffect(() {
                                if (pokemon.value == null) {
                                  fetchData(
                                      pokemon, uri, parseToPokemonSimplified,
                                      dataState: pokemonRawData);
                                }
                                return () {};
                              }, [pokemon.value, allPokemons.value]);
                              if (pokemon.value == null) {
                                return const Center(
                                  widthFactor: .3,
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return GestureDetector(
                                onTap: () {
                                  GoRouter.of(context)
                                      .goNamed("pokemon-details", queryParams: {
                                    "uri": uri,
                                    "content":
                                        json.encode(pokemonRawData.value),
                                  });
                                },
                                child: Card(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: getTypeColor(
                                          pokemon.value.types[0].name),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          bottom: -10,
                                          right: -10,
                                          child: Image.asset(
                                            "images/pokeball.png",
                                            height: 100,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                        Positioned(
                                          top: 20,
                                          left: 65,
                                          child: CachedNetworkImage(
                                            imageUrl: pokemon.value.sprites
                                                .officialFrontDefault,
                                            height: 100,
                                            fit: BoxFit.fitHeight,
                                            placeholder: (context, url) =>
                                                const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 10,
                                          left: 10,
                                          child: Text(
                                            capitalize(name),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              shadows: [
                                                BoxShadow(
                                                    color: Colors.black,
                                                    offset: Offset(0, 0),
                                                    spreadRadius: 1.0,
                                                    blurRadius: 3)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 10,
                                          left: 10,
                                          child: Wrap(
                                            spacing: 5,
                                            direction: Axis.vertical,
                                            children: renderPrimaryTypes(
                                                pokemon.value.types),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.4,
                        ),
                      ),
                    ),
                  ),
                  // ElevatedButton(onPressed: () {}, child: const Text("Hola"))
                  Wrap(
                    spacing: 5,
                    children: [
                      ElevatedButton(
                        onPressed: allPokemons.value.previous == null
                            ? null
                            : () {
                                pagePokemonUri.value =
                                    allPokemons.value.previous;
                                allPokemons.value = null;
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text("<"),
                      ),
                      ElevatedButton(
                        onPressed: allPokemons.value.next == null
                            ? null
                            : () {
                                pagePokemonUri.value = allPokemons.value.next;
                                allPokemons.value = null;
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text(">"),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ]),
    );
  }
}
