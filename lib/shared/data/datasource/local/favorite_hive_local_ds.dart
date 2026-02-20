import '../../models/pokemon.dart';

abstract class FavoriteHiveLocalDs {
  Future<void> savePokeName(Pokemon poke);

  Pokemon? getPokeName(String id);

  Future<void> deletePokeName(String id);

  Stream<List<Pokemon>> watchPokemon();

  List<Pokemon> getinitialFavorites();
}
