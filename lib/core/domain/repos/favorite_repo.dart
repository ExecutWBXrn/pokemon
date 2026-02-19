import 'package:pokemon/core/domain/entities/pokemon_entity.dart';

abstract class FavoriteRepo {
  Future<void> savePokeName(PokemonEntity poke);

  Future<PokemonEntity?> getPokeName(String id);

  Future<void> deletePokeName(String id);

  Stream<List<PokemonEntity>> watchPokemon();

  List<PokemonEntity> getinitialFavorites();
}
