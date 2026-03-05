import 'package:pokemon/shared/domain/entities/pokemon_entity.dart';
import '../../domain/repos/favorite_repo.dart';
import 'package:pokemon/shared/data/datasource/local/favorite_hive_local_ds.dart';
import 'package:pokemon/shared/data/exceptions/cache_exception.dart';
import '../models/pokemon.dart';

class FavoriteRepoImpl extends FavoriteRepo {
  final FavoriteHiveLocalDs _localHiveDs;

  FavoriteRepoImpl(this._localHiveDs);

  @override
  Future<void> deletePokeName(PokemonEntity poke) async {
    try {
      await _localHiveDs.deletePokeName(Pokemon.fromEntity(poke));
    } on CacheException catch (e) {
      throw CacheException(e.message);
    }
  }

  @override
  PokemonEntity? getPokeName(int id) {
    try {
      final model = _localHiveDs.getPokeName(id);
      return model?.toEntity();
    } on CacheException catch (e) {
      throw CacheException(e.message);
    }
  }

  @override
  List<PokemonEntity> getInitialFavorites() {
    try {
      final modelList = _localHiveDs.getInitialFavorites();
      return modelList.map((model) => model.toEntity()).toList();
    } on CacheException catch (e) {
      throw CacheException(e.message);
    }
  }

  @override
  Future<void> savePokeName(PokemonEntity poke) async {
    try {
      _localHiveDs.savePokeName(Pokemon.fromEntity(poke));
    } on CacheException catch (e) {
      throw CacheException(e.message);
    }
  }

  @override
  Stream<List<PokemonEntity>> watchPokemon() {
    try {
      final streamModel = _localHiveDs.watchPokemon();
      return streamModel.map((modelList) {
        return modelList.map((model) => model.toEntity()).toList();
      });
    } on CacheException catch (e) {
      throw CacheException(e.message);
    }
  }
}
