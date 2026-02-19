import 'package:pokemon/core/domain/entities/pokemon_entity.dart';
import '../../domain/repos/favorite_repo.dart';
import 'package:pokemon/core/data/datasource/local/favorite_hive_local_ds.dart';

import '../models/pokemon.dart';

class FavoriteRepoImpl extends FavoriteRepo {
  final FavoriteHiveLocalDs _localHiveDs;

  FavoriteRepoImpl(this._localHiveDs);

  @override
  Future<void> deletePokeName(String id) async {
    try {
      await _localHiveDs.deletePokeName(id);
    } catch (e, st) {
      print(e);
    }
  }

  @override
  Future<PokemonEntity?> getPokeName(String id) async {
    try {
      final model = await _localHiveDs.getPokeName(id);
      return model?.toEntity();
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  List<PokemonEntity> getinitialFavorites() {
    try {
      final modelList = _localHiveDs.getinitialFavorites();
      return modelList.map((model) => model.toEntity()).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<void> savePokeName(PokemonEntity poke) async {
    try {
      _localHiveDs.savePokeName(Pokemon.fromEntity(poke));
    } catch (e) {
      print(e);
    }
  }

  @override
  Stream<List<PokemonEntity>> watchPokemon() {
    try {
      final streamModel = _localHiveDs.watchPokemon();
      return streamModel.map((modelList) {
        return modelList.map((model) => model.toEntity()).toList();
      });
    } catch (e) {
      print(e);
      return Stream.value([]);
    }
  }
}
