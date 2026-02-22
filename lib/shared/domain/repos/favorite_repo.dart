import 'package:pokemon/shared/domain/entities/pokemon_entity.dart';

abstract class FavoriteRepo {
  Future<void> savePokeName(PokemonEntity poke);

  PokemonEntity? getPokeName(int id);

  Future<void> deletePokeName(PokemonEntity id);

  Stream<List<PokemonEntity>> watchPokemon();

  List<PokemonEntity> getInitialFavorites();
}
