import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fulltimeforce_test/pokemon/pokemon/pokemon_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class PokemonScreen extends HookWidget {
  final String uri;
  const PokemonScreen({super.key, required this.uri});

  @override
  Widget build(BuildContext context) {
    final pokemon = useState<dynamic>(null);

    useEffect(() {
      fetchPokemon(pokemon);
      return () {};
    }, []);
    return Scaffold(
      body: Column(children: [
        ElevatedButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          child: const Text("Hola"),
        ),
        Text(
          pokemon.toString(),
        ),
      ]),
    );
  }

  void fetchPokemon(ValueNotifier<dynamic> pokemon) async {
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode != 200) {
      throw Exception("Failed to load pokemon data");
    }
    pokemon.value = parseToPokemon(jsonDecode(response.body));
  }
}
