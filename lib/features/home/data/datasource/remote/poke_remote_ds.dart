import '/core/data/models/pokemon.dart';

abstract class PokeRemoteDs {
  Future<List<Pokemon>> getAllPokemons();
  Future<Pokemon?> getPokemonById(String id);
}
