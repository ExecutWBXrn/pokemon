import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/blogic/favorite_pokemon_provider.dart';
import 'package:pokemon/blogic/pokemon.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritePokemons extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Pokemon>> pokemonAsync = ref.watch(
      favotiresStreamProvider,
    );

    return Center(
      child: pokemonAsync.when(
        data: (pokemons) {
          return Center(
            child: ListView.builder(
              itemCount: pokemons.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Hero(
                    tag: 'avatar-${pokemons[index].id}-flist',
                    child: Image.network(
                      pokemons[index].img,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.image_not_supported_outlined);
                      },
                    ),
                  ),
                  title: Text(
                    pokemons[index].name.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/info',
                      arguments: <String, String>{
                        'pokeId': pokemons[index].id,
                        'pageFrom': 'flist',
                      },
                    );
                  },
                );
              },
            ),
          );
        },
        error: (e, s) {
          return const Center(child: Text("data"));
        },
        loading: () {
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
