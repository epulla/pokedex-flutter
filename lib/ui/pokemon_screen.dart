import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fulltimeforce_test/pokemon/pokemon/pokemon.dart';
import 'package:fulltimeforce_test/pokemon/pokemon/pokemon_controller.dart';
import 'package:fulltimeforce_test/shared/utils/colors_manipulation.dart';
import 'package:fulltimeforce_test/shared/utils/fetch_data.dart';
import 'package:fulltimeforce_test/shared/utils/string_manipulation.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';

class PokemonScreen extends HookWidget {
  final String uri;
  final String content;
  const PokemonScreen({super.key, required this.uri, required this.content});

  @override
  Widget build(BuildContext context) {
    final pokemon = parseToPokemon(json.decode(content));

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: getTypeColor(pokemon.types[0].name),
      body: Stack(
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
              height: height * 0.6,
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
                            pokemon.height.toString(),
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
                            pokemon.weight.toString(),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.3,
                            child: Text(
                              capitalize(pokemon.stats[0].name),
                              style: const TextStyle(
                                  color: Colors.blueGrey, fontSize: 17),
                            ),
                          ),
                          LinearPercentIndicator(
                            animation: true,
                            width: width * .3,
                            lineHeight: 14.0,
                            percent: 0.5,
                            backgroundColor: Colors.grey,
                            progressColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
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
    );
  }
}
