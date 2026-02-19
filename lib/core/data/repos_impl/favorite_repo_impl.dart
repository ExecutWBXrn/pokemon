import 'package:pokemon/core/domain/entities/pokemon_entity.dart';
import 'package:pokemon/core/failure/cache_failure.dart';
import '../../domain/repos/favorite_repo.dart';
import 'package:pokemon/core/data/datasource/local/favorite_hive_local_ds.dart';
import 'package:pokemon/core/exceptions/cache_exception.dart';
import '../models/pokemon.dart';

class FavoriteRepoImpl extends FavoriteRepo {
  final FavoriteHiveLocalDs _localHiveDs;

  FavoriteRepoImpl(this._localHiveDs);

  @override
  Future<void> deletePokeName(String id) async {
    try {
      await _localHiveDs.deletePokeName(id);
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
    }
  }

  @override
  PokemonEntity? getPokeName(String id) {
    try {
      final model = _localHiveDs.getPokeName(id);
      return model?.toEntity();
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
    }
  }

  @override
  List<PokemonEntity> getinitialFavorites() {
    try {
      final modelList = _localHiveDs.getinitialFavorites();
      return modelList.map((model) => model.toEntity()).toList();
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
    }
  }

  @override
  Future<void> savePokeName(PokemonEntity poke) async {
    try {
      _localHiveDs.savePokeName(Pokemon.fromEntity(poke));
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
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
      throw CacheFailure(e.message);
    }
  }
}
