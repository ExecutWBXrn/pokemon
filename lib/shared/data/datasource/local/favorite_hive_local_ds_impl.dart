import 'package:hive/hive.dart';
import '/shared/data/models/pokemon.dart';
import '../../exceptions/cache_exception.dart';
import 'favorite_hive_local_ds.dart';

class FavoriteHiveLocalDsImpl extends FavoriteHiveLocalDs {
  final Box<Pokemon> _box;

  FavoriteHiveLocalDsImpl(this._box);

  @override
  Future<void> deletePokeName(String id) async {
    try {
      await _box.delete(id);
    } on HiveError catch (e) {
      throw CacheException(e.message);
    } catch (e) {
      throw CacheException('Unknown error');
    }
  }

  @override
  Pokemon? getPokeName(String id) {
    try {
      return _box.get(id);
    } on HiveError catch (e) {
      throw CacheException(e.message);
    } catch (e) {
      throw CacheException('Unknown error');
    }
  }

  @override
  List<Pokemon> getInitialFavorites() {
    try {
      return _box.values.toList();
    } on HiveError catch (e) {
      throw CacheException(e.message);
    } catch (e) {
      throw CacheException('Unknown error');
    }
  }

  @override
  Future<void> savePokeName(Pokemon poke) async {
    try {
      await _box.put(poke.id, poke);
    } on HiveError catch (e) {
      throw CacheException(e.message);
    } catch (e) {
      throw CacheException('Unknown error');
    }
  }

  @override
  Stream<List<Pokemon>> watchPokemon() {
    try {
      return _box.watch().map((event) {
        return _box.values.toList();
      });
    } on HiveError catch (e) {
      throw CacheException(e.message);
    } catch (e) {
      throw CacheException('Unknown error');
    }
  }
}
