import 'package:fulltimeforce_test/ui/home_screen.dart';
import 'package:fulltimeforce_test/ui/pokemon_screen.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: <RouteBase>[
        GoRoute(
          name: "pokemon-details",
          path: 'pokemon-details',
          builder: (context, state) {
            return PokemonScreen(
              uri: state.queryParams['uri']!,
              content: state.queryParams['content']!,
            );
          },
        ),
      ],
    ),
  ],
);
