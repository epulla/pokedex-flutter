import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fulltimeforce_test/pokemon/pokemon_all/pokemon_all_controller.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  final String allPokemonsUri = "https://pokeapi.co/api/v2/pokemon";

  @override
  Widget build(BuildContext context) {
    final allPokemons = useState<dynamic>(null);

    useEffect(() {
      fetchPokemons(allPokemons);
      return () {};
    }, []);

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
          top: 80,
          left: 20,
          child: Text(
            'Pokedex',
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.bold,
              fontSize: 30,
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
                        itemCount: allPokemons.value == null
                            ? 0
                            : allPokemons.value.pokemons.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Container(
                              // height: 290,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: -10,
                                    right: -10,
                                    child: Image.asset(
                                      'images/pokeball.png',
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  Positioned(
                                    child: Text(
                                        allPokemons.value.pokemons[index].name),
                                  ),
                                ],
                              ),
                            ),
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
                  ElevatedButton(onPressed: () {}, child: const Text("Hola"))
                ],
              );
            },
          ),
        ),
        Positioned(
          top: 130,
          bottom: 0,
          width: MediaQuery.of(context).size.width,
          child: const Icon(
            Icons.arrow_downward,
            color: Colors.black12,
            size: 24,
          ),
        )
      ]),
    );
  }

  void fetchPokemons(ValueNotifier<dynamic> allPokemons) async {
    final response = await http.get(Uri.parse(allPokemonsUri));
    if (response.statusCode != 200) {
      throw Exception("Failed to load data");
    }
    // Similar to setAllPokemons
    allPokemons.value = parseToPokemonAll(jsonDecode(response.body));
  }
}
