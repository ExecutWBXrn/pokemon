// libs

import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/blogic/pokemon.dart';

class FavoriteRepository {
  static const _boxName = 'poke_favorite';

  Box<Pokemon> get _box => Hive.box<Pokemon>(_boxName);

  Future<void> savePokeName(Pokemon poke) async {
    return _box.put(poke.id, poke);
  }

  Future<Pokemon?> getPokeName(String id) async {
    return _box.get(id);
  }

  Future<void> deletePokeName(String id) async {
    return _box.delete(id);
  }

  Stream<List<Pokemon>> watchPokemon() {
    return _box.watch().map((event) {
      return _box.values.toList();
    });
  }

  List<Pokemon> getinitialFavorites() {
    return _box.values.toList();
  }
}

final favoriteRepositoryProvider = Provider((ref) => FavoriteRepository());

final favoritePokeProvider = FutureProvider.family<Pokemon?, String>((ref, id) {
  final repository = ref.watch(favoriteRepositoryProvider);
  return repository.getPokeName(id);
});

final favotiresStreamProvider = StreamProvider.autoDispose<List<Pokemon>>((
  ref,
) {
  final repository = ref.watch(favoriteRepositoryProvider);

  final controller = StreamController<List<Pokemon>>();

  final initialData = repository.getinitialFavorites();
  controller.add(initialData);

  final subscription = repository.watchPokemon().listen((updatedList) {
    if (!controller.isClosed) {
      controller.add(updatedList);
    }
  });

  ref.onDispose(() {
    subscription.cancel();
    controller.close();
  });

  return controller.stream;
});
