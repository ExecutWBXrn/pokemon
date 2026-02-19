import 'package:dio/dio.dart';
import 'package:pokemon/core/domain/entities/pokemon_entity.dart';
import '../datasource/remote/poke_remote_ds.dart';
import '../../domain/repos/pokemon_repo.dart';

class PokemonRepoImpl implements PokemonRepo {
  final PokeRemoteDs _remoteDs;

  PokemonRepoImpl(this._remoteDs);

  @override
  Future<List<PokemonEntity>> getAllPokemons() async {
    try {
      final pokeModels = await _remoteDs.getAllPokemons();
      return pokeModels.map((model) => model.toEntity()).toList();
    } on DioException catch (e) {
      print(e.message);
      rethrow;
    }
  }

  @override
  Future<PokemonEntity?> getPokemonById(String id) async {
    try {
      final pokeModel = await _remoteDs.getPokemonById(id);
      return pokeModel?.toEntity();
    } on DioException catch (e) {
      print(e.message);
      rethrow;
    }
  }
}
