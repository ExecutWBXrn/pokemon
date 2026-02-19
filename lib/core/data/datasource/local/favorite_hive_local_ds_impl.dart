import 'package:hive/hive.dart';
import 'package:pokemon/core/data/models/pokemon.dart';

import './favorite_hive_local_ds.dart';

class FavoriteHiveLocalDsImpl extends FavoriteHiveLocalDs {
  final Box<Pokemon> _box;

  FavoriteHiveLocalDsImpl(this._box);

  @override
  Future<void> deletePokeName(String id) async {
    try {
      await _box.delete(id);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Pokemon?> getPokeName(String id) async {
    try {
      return _box.get(id);
    } catch (_) {
      rethrow;
    }
  }

  @override
  List<Pokemon> getinitialFavorites() {
    try {
      return _box.values.toList();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> savePokeName(Pokemon poke) async {
    try {
      await _box.put(poke.id, poke);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Stream<List<Pokemon>> watchPokemon() {
    try {
      return _box.watch().map((event) {
        return _box.values.toList();
      });
    } catch (_) {
      rethrow;
    }
  }
}
