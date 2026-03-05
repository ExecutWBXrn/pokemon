import '../../models/pokemon.dart';

abstract class FavoriteHiveLocalDs {
  Future<void> savePokeName(Pokemon poke);

  Pokemon? getPokeName(int id);

  Future<void> deletePokeName(Pokemon poke);

  Stream<List<Pokemon>> watchPokemon();

  List<Pokemon> getInitialFavorites();
}
