//  libs

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// BLOGIC

import 'package:pokemon/blogic/dio_provider.dart';
import 'package:pokemon/blogic/pokemon.dart';

class PokemonApiService {
  final DioService _dioInstance;

  PokemonApiService(this._dioInstance);

  Future<List<Pokemon>> getAllPokemons({CancelToken? cancelToken}) async {
    List<Pokemon> allPokemons = <Pokemon>[];
    try {
      final response = await _dioInstance.getDio().get(
        '',
        queryParameters: {'offset': 0, 'limit': 1025},
        cancelToken: cancelToken,
      );
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
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        print('Request for pokemon\'s was cancelled.');
      }
    }

    return allPokemons;
  }

  Future<Pokemon?> getPokemonById(String id, {CancelToken? cancelToken}) async {
    try {
      final response = await _dioInstance.getDio().get(
        '/$id',
        cancelToken: cancelToken,
      );

      Pokemon? pokemon;

      if (response.statusCode == 200) {
        final data = response.data;
        pokemon = Pokemon.fromJson(data);
      }

      return pokemon;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        print('Request for pokemon $id was cancelled.');
      }
      rethrow;
    }
  }
}

final _pokemonReposetoryProvider = Provider<PokemonApiService>((ref) {
  final dioService = ref.watch(dioProvider);

  return PokemonApiService(dioService);
});

final allPokemonsProvider = FutureProvider.autoDispose<List<Pokemon>>((ref) {
  final allPokes = ref.watch(_pokemonReposetoryProvider);
  final cancelToken = CancelToken();

  ref.onDispose(() {
    print("Disposed");
    cancelToken.cancel();
  });

  return allPokes.getAllPokemons(cancelToken: cancelToken);
});

final pokemonProvider = FutureProvider.autoDispose.family<Pokemon?, String>((
  ref,
  pokeId,
) {
  print("Creating provider for $pokeId");

  final link = ref.keepAlive();
  final cancelToken = CancelToken();

  final timer = Timer(Duration(minutes: 1), () {
    link.close();
  });

  ref.onDispose(() {
    print("Disposing provider for $pokeId");
    cancelToken.cancel();
  });

  final poke = ref.watch(_pokemonReposetoryProvider);
  return poke.getPokemonById(pokeId, cancelToken: cancelToken);
});
