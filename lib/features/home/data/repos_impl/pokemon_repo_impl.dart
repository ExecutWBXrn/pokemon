import 'dart:developer';
import 'package:pokemon/shared/data/exceptions/network_exception.dart';
import 'package:pokemon/shared/domain/entities/pokemon_entity.dart';
import '/shared/domain/enums/network_failure_enum.dart';
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
    } on NetworkException catch (e, st) {
      log('Error in getAllPokemons', error: e, stackTrace: st);
      throw NetworkException(e.type);
    } catch (e, st) {
      log('Error in getAllPokemons', error: e, stackTrace: st);
      throw NetworkException(NetworkFailureEnum.unknown);
    }
  }

  @override
  Future<PokemonEntity?> getPokemonById(int id) async {
    try {
      final pokeModel = await _remoteDs.getPokemonById(id);
      return pokeModel?.toEntity();
    } on NetworkException catch (e, st) {
      log('Error in getPokemonById', error: e, stackTrace: st);
      throw NetworkException(e.type);
    } catch (e, st) {
      log('Error in getPokemonById', error: e, stackTrace: st);
      throw NetworkException(NetworkFailureEnum.unknown);
    }
  }
}
