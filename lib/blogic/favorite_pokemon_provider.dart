// libs

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/blogic/pokemon.dart';

class FavoriteRepository {
  static const _boxName = 'poke_favorite';

  Future<Box<Pokemon>> _openBox() async {
    return Hive.box<Pokemon>(_boxName);
  }

  Future<void> savePokeName(Pokemon poke) async {
    final box = await _openBox();
    return box.put(poke.id, poke);
  }

  Future<Pokemon?> getPokeName(String id) async {
    final box = await _openBox();
    return box.get(id);
  }

  Future<void> deletePokeName(String id) async {
    final box = await _openBox();
    return box.delete(id);
  }
}

final favoriteRepositoryProvider = Provider((ref) => FavoriteRepository());

final favoritePokeProvider = FutureProvider.family<Pokemon?, String>((ref, id) {
  final repository = ref.watch(favoriteRepositoryProvider);
  return repository.getPokeName(id);
});
