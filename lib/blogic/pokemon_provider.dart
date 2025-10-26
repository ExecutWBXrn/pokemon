//  libs

import 'package:flutter_riverpod/flutter_riverpod.dart';

// BLOGIC

import 'package:pokemon/blogic/dio_provider.dart';
import 'package:pokemon/blogic/pokemon.dart';

class PokemonApiService {
  final DioService _dioInstance;

  PokemonApiService(this._dioInstance);

  Future<List<Pokemon>> getAllPokemons() async {
    final response = await _dioInstance.getDio().get(
      '',
      queryParameters: {'offset': 0, 'limit': 1025},
    );

    List<Pokemon> allPokemons = <Pokemon>[];

    if (response.statusCode == 200) {
      final data = response.data;
      final List pokemons = data['results'];
      for (int i = 0; i < pokemons.length; i++) {
        allPokemons.add(Pokemon.fromJsonById(pokemons[i], i + 1));
      }
    } else {
      allPokemons = <Pokemon>[
        Pokemon(
          id: "1",
          name: "bulbasaur",
          img:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
        ),
        Pokemon(
          id: "2",
          name: "ivysaur",
          img:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png',
        ),
        Pokemon(
          id: "3",
          name: "venusaur",
          img:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png',
        ),
        Pokemon(
          id: "4",
          name: "charmander",
          img:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
        ),
        Pokemon(
          id: "25",
          name: "pikachu",
          img:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png',
        ),
      ];
    }

    return allPokemons;
  }

  Future<Pokemon?> getPokemonById(String id) async {
    final response = await _dioInstance.getDio().get('/$id');

    Pokemon? pokemon;

    if (response.statusCode == 200) {
      final data = response.data;
      pokemon = Pokemon.fromJson(data);
    }

    return pokemon;
  }
}

final _pokemonReposetoryProvider = Provider<PokemonApiService>((ref) {
  final dioService = ref.watch(dioProvider);

  return PokemonApiService(dioService);
});

final allPokemonsProvider = FutureProvider<List<Pokemon>>((ref) {
  final allPokes = ref.watch(_pokemonReposetoryProvider);
  return allPokes.getAllPokemons();
});

final pokemonProvider = FutureProvider.family<Pokemon?, String>((ref, pokeId) {
  final poke = ref.watch(_pokemonReposetoryProvider);
  return poke.getPokemonById(pokeId);
});
