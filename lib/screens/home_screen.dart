// libs

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';


// BLOGIC

import 'package:pokemon/blogic/pokemon.dart';
import 'package:pokemon/blogic/pokemon_provider.dart';


class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Pokemon>> allPokemonList = ref.watch(
      allPokemonsProvider,
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          "Pokemon",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.yellow,
            shadows: [Shadow(color: Colors.blue, blurRadius: 25)],
          ),
        ),
      ),
      body: Center(
        child: allPokemonList.when(
          data: (data) {
            return ListView.builder(
              itemCount: allPokemonList.value?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Hero(
                    tag: 'avatar-${allPokemonList.value![index].id}',
                    child: Image.network(allPokemonList.value![index].img),
                  ),
                  title: Text(
                    allPokemonList.value![index].name.toUpperCase(),
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
                        'pokeId': allPokemonList.value![index].id,
                      },
                    );
                  },
                );
              },
            );
          },
          error: (error, stack) {
            print("$error");
            return const Text("No pokemons today");
          },
          loading: () {
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
