import 'package:hive/hive.dart';
import '../../services/notification_service.dart';
import '/shared/data/models/pokemon.dart';
import '../../exceptions/cache_exception.dart';
import 'favorite_hive_local_ds.dart';

class FavoriteHiveLocalDsImpl extends FavoriteHiveLocalDs {
  final Box<Pokemon> _box;
  final NotificationService _notificationService;

  FavoriteHiveLocalDsImpl(this._box, this._notificationService);

  @override
  Future<void> deletePokeName(Pokemon poke) async {
    try {
      await _box.delete("pokemon_${poke.id}");
      await _notificationService.showNotification(
        poke.id,
        title: poke.name,
        body: "Removed from favorites",
      );
    } on HiveError catch (e) {
      throw CacheException(e.message);
    } catch (e, st) {
      throw CacheException('Unknown error');
    }
  }

  @override
  Pokemon? getPokeName(int id) {
    try {
      return _box.get("pokemon_$id");
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
      await _box.put("pokemon_${poke.id}", poke);
      await _notificationService.showNotification(
        poke.id,
        title: poke.name,
        body: "Added to favorites",
      );
    } on HiveError catch (e) {
      throw CacheException(e.message);
    } catch (e, st) {
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
